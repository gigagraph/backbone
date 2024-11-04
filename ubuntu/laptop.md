# Notes on setting up Ubuntu on laptop

The laptop has a newer hardware that requires driver from the newer kernel version (6.8+). Not all linux distributions have this version yet. Ubuntu 24.04 has this kernel version.

Ubuntu 24.04 updated installer from the legacy one to the new one called [`subiquity`][subiquity]. Unfortunately, as of that Ubuntu release the installer does not support LVM and LUKS volumes during the partitioning stage <sup>\[[ubuntu-lvm-luks-volumes-bug-answer][ubuntu-lvm-luks-volumes-bug-answer]\]</sup> <sup>\[[ubuntu-lvm-luks-volumes-bug-thread][ubuntu-lvm-luks-volumes-bug-thread]\]</sup>. Ubuntu community recommends to use the legacy installer to [install the initial system initially](#install-ubuntu-with-the-legacy-installer-with-full-disk-encryption-with-luks) and then [upgrade to the latest release from the installed system](#upgrade-ubuntu-release). The latest Ubuntu release with the legacy installer is **23.04** - [`ubuntu-23.04-beta-desktop-`**`legacy`**`-amd64.iso`][old-ubuntu-releases].

1. Download Ubuntu Live USB image with the legacy installer.
2. Download the corresponding `SHA256SUMS` file.
3. Verify that the downloaded release matches the corresponding sha256 sum: `sha256sum -c SHA256SUMS`.
4. Insert the flash drive that you will use for to boot the Live image.
5. Make the GPT2 partition table on the flash drive and format the flash drive's filesystem as **FAT**.
6. Assuming that the flash drive device file is `/dev/sdb`, flash it with the Live image: `cp ubuntu-23.04-beta-desktop-legacy-amd64.iso /dev/sdb`.
7. After the previous command exists, unmount the flash drive and unplug it.

## Install Ubuntu with the legacy installer with full disk encryption with LUKS

Follow the [Full Disk Encryption guide][ubuntu-full-disk-encryption-guide].

### Disk partitioning and LVM on LUKS

#### Partition the disk

Partition the disk, e.g. with `fdisk`. Create the following raw volumes:

- `nvme0n1p1` (2G) - the EFI partition, i.e. its filesystem will be FAT and the mountpoint will be `/boot/efi`. We will not encrypt this partition; otherwise EFI will not be able to start grub, because it will be encrypted.
- `nvme0n1p2` (2G) - partition for the `/boot` mountpoint. Grub can boot from a [LUKS][wiki-luks] partition, however, the support for `luks2` is limited, so you will need to encrypt it with  `--type luks1`.
- `nvme0n1p3` (rest) - you will encrypt this volume with LUKS2, and set it up an LVM physical volume and a `main` volume group on it. Under the volume group, you will create logical volumes for the relevant mountpoints where installer will setup the system.

#### Encrypt the partitions with LUKS

Encrypt the partitions with the following commands:

```shell
cryptsetup luksFormat --type=luks1 --cipher aes --key-size 256 /dev/nvme0n1p2
cryptsetup luksFormat --cipher aes --key-size 256 /dev/nvme0n1p3
```

Unlock the encrypted LUKS partitions:

```shell
cryptsetup open /dev/nvme0n1p2 luks-boot
cryptsetup open /dev/nvme0n1p3 luks-main

# Check that `cryptsetup` decrypted the partitions
lsblk
ls /dev/mapper/
# You should see the files called:
# - luks-boot
# - luks-main
```

#### Format the EFI partition

Format EFI partition (`nvme0n1p1`) with the filesystem:

```shell
mkfs.vfat -F 16 -n EFI-SP /dev/nvme0n1p1
```

You will format the rest of the partitions in the installer UI.

#### Create LVM volumes

Create an [LVM][arch-wiki-lvm] physical volume from the `luks-main` opened LUKS partition:

```shell
pvcreate /dev/mapper/luks-main
```

Create the `main` volume group on the physical volume:

```shell
vgcreate main /dev/mapper/luks-main
```

Create the logical volumes for the mount points:

```shell
# Mount point /
lvcreate -L 60G -n root main
# Mount point /opt
lvcreate -L 50G -n opt main
# Mount point /usr/local
lvcreate -L 50G -n usr-local main
# Mount point /var
lvcreate -L 20G -n var main
# Mount point /tmp
lvcreate -L 8G -n tmp main
# Swap
# For the size of the swap volume see the recommendation from Red Hat:  https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices#recommended-system-swap-space_getting-started-with-swap 
lvcreate -L _G -n swap main
# Mount point /home
lvcreate -l 100%FREE -n home main
```

#### Install Ubuntu

Run the installer and follow the installation steps.

In the partitioning section select manual partitioning. Select the `nvme0n1` as a disk to boot from. Make sure `nvme0n1p1` is the EFI partition. Select the corresponding mount points in the manual partitioning UI for `/boot` and other directories. Format the LVM logical volumes and `/dev/mapper/luks-boot` as `ext4` filesystems.

Enable encrypted GRUB before the installer reaches the **Install Bootloader** stage:

```shell
while [ ! -d /target/etc/default/grub.d ]; do sleep 1; done; echo "GRUB_ENABLE_CRYPTODISK=y" > /target/etc/default/grub.d/local.cfg
```

If you do not manage to do this, see the [**Ensure GRUB configuration supports LUKS**](#ensure-grub-configuration-supports-luks) section.

#### Make GRUB ask for a password to decrypt the volumes on boot

```shell
mount /dev/main/root /target
for n in proc sys dev etc/resolv.conf; do mount --rbind /$n /target/$n; done
chroot /target
mount -a

# Add a key to both partitions, so that GRUB decrypts the boot partition it can
# also automatically decrypt the other partition.
apt install -y cryptsetup-initramfs

echo "KEYFILE_PATTERN=/etc/luks/*.keyfile" >> /etc/cryptsetup-initramfs/conf-hook
echo "UMASK=0077" >> /etc/initramfs-tools/initramfs.conf

# Create a key and add it to LUKS volumes
mkdir /etc/luks
dd if=/dev/urandom of=/etc/luks/boot_os.keyfile bs=512 count=1

chmod u=rx,go-rwx /etc/luks
chmod u=r,go-rwx /etc/luks/boot_os.keyfile

cryptsetup luksAddKey /dev/nvme0n1p2 /etc/luks/boot_os.keyfile
cryptsetup luksAddKey /dev/nvme0n1p3 /etc/luks/boot_os.keyfile


echo "luks-boot UUID=$(blkid -s UUID -o value /dev/nvme0n1p2) /etc/luks/boot_os.keyfile luks,discard" >> /etc/crypttab
echo "luks-main UUID=$(blkid -s UUID -o value /dev/nvme0n1p3) /etc/luks/boot_os.keyfile luks,discard" >> /etc/crypttab

# Update initialramfs files to add the cryptsetup unlocking scripts and the key-file
update-initramfs -u -k all
```

#### Ensure GRUB configuration supports LUKS

If you did not manage to write `GRUB_ENABLE_CRYPTODISK=y` to `/target/etc/default/grub.d/local.cfg` before the installer set up GRUB, you can configure it manually. The config parameter must be written to the file before running this command:

```shell
dpkg-reconfigure grub-efi-amd64-signed
```

It is safe to rerun this command multiple times.

### Reboot the system

Reboot the system after teh installer is finished and after you ran the post-installation commands from above.

If everything is done correctly, the system should boot. Otherwise, you can use the Live USB and the [**Useful links**](#useful-links) to debug the setup. Use the [commands from the GRUB setup](#make-grub-ask-for-a-password-to-decrypt-the-volumes-on-boot) to mount the installed system so that you can debug and reconfigure the setup.

## Upgrade Ubuntu release

Follow the [official Ubuntu guide to upgrade the system to the next release][how-to-upgrade-ubuntu-release]:

```shell
sudo apt update -y && sudo apt upgrade -y --allow-downgrades
sudo do-release-upgrade
```

### End of Life upgrades

It will probably be the case that the upgrader will not be able to upgrade Ubuntu to the proper release. In this case, follow the [instructions from the **EOLUpgrades** article][ubuntu-eof-upgrades].

Find the link for the upgrader for a release that immediately follows the currently installed release in the `meta-release` file: https://changelogs.ubuntu.com/meta-release, e.g.:

```
UpgradeTool: http://archive.ubuntu.com/ubuntu/dists/mantic-updates/main/dist-upgrader-all/current/mantic.tar.gz
```

Download, unpack the downloaded upgrader, and run it:

```shell
wget http://archive.ubuntu.com/ubuntu/dists/mantic-updates/main/dist-upgrader-all/current/mantic.tar.gz
mkdir ./mantic-upgrader
tar -xaf mantic.tar.gz -C ./mantic-upgrader
cd ./mantic-upgrader
./mantic
```

Repeat this process up until you get to the desired release.

## Post-installation setup

Before proceeding, set up the [Firefox Developer Edition browser][../system-setup/firefox.md].

### Disable snap

[Main guide][baeldung-disable-snaps].

#### Check snap and packages

Check if the system has snap installed and list the installed packages:

```shell
# Check the snap version
snap --version

# List the installed snaps
snap list

# Approximate output
# Name                       Version           Rev    Tracking         Publisher   Notes
# bare                       1.0               5      latest/stable    canonical✓  base
# core22                     20241001          1663   latest/stable    canonical✓  base
# firefox                    111.0-2           2453   latest/stable/…  mozilla✓    -
# firmware-updater           0+git.7983059     147    1/stable/…       canonical✓  -
# gnome-42-2204              0+git.09673a5     65     latest/stable/…  canonical✓  -
# gtk-common-themes          0.1-81-g442e511   1535   latest/stable/…  canonical✓  -
# snap-store                 41.3-76-g2e8f3b0  935    2/stable/…       canonical✓  -
# snapd                      2.63              21759  latest/stable    canonical✓  snapd
# snapd-desktop-integration  0.9               253    latest/stable/…  canonical✓  -
```

#### Remove snap packages

Remove the snap packages. They must be removed in a topological order. Unfortunately, snap does not provide a way to return the installed packages in a topological order, so this guide provides generate the commands to remove the packages. You should run these commands manully and figure out the proper order:

```shell
snap list | tail -n +2 | awk '{ print $1 }' | sort -r | xargs -I {} -n 1 echo "sudo snap remove --purge {}"
```

#### Remove `snapd` daemon

```shell
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd -y
sudo apt-mark hold snapd
rm -rf "${HOME}/snap/"
```

#### Configure `apt` to not install snaps

```shell
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
```

Check that `apt` will not install snaps without an explicit reconfiguration. `chromium-browser` package is a package that `apt` will try to install with snap. The following command should fail:

```shell
sudo apt install chromium-browser

# Reading package lists... Done
# Building dependency tree... Done
# Reading state information... Done
# Some packages could not be installed. This may mean that you have
# requested an impossible situation or if you are using the unstable
# distribution that some required packages have not yet been created
# or been moved out of Incoming.
# The following information may help resolve the situation:
#
# The following packages have unmet dependencies:
#  chromium-browser : PreDepends: snapd but it is not installable
# E: Unable to correct problems, you have held broken packages.
```

#### Remove the rest of snap directories

Find the directories that have the names `snap` or `snapd` and remove them manually (unless they are in system locations, e.g. like ``):

```shell
sudo find / -name "snap"
sudo find / -name "snapd"
```

### Further system setup

Once you finish the setup from this section - perform the desired setup from the [`system-setup`](./system-setup/README.md).

## Useful links

### Ubuntu installer

- [`subiquity`][subiquity]
- [ubuntu-lvm-luks-volumes-bug-answer][ubuntu-lvm-luks-volumes-bug-answer]
- [ubuntu-lvm-luks-volumes-bug-thread][ubuntu-lvm-luks-volumes-bug-thread]

[subiquity]: <https://github.com/canonical/subiquity>
[ubuntu-lvm-luks-volumes-bug-answer]: <https://answers.launchpad.net/ubuntu/+source/ubiquity/+question/706331>
[ubuntu-lvm-luks-volumes-bug-thread]: <https://bugs.launchpad.net/ubuntu-desktop-provision/+bug/2058511>

### Full disk encryption with LUKS

- [ubuntu-full-disk-encryption-guide][ubuntu-full-disk-encryption-guide]
- [wiki-luks][wiki-luks]
- [arch-wiki-encrypt-entire-fs][arch-wiki-encrypt-entire-fs]
- [arch-wiki-device-encryption][arch-wiki-device-encryption]
- [arch-wiki-grub-encrypted-boot][arch-wiki-grub-encrypted-boot]
- [cryptsetup-man-8][cryptsetup-man-8]

[ubuntu-full-disk-encryption-guide]: <https://help.ubuntu.com/community/Full_Disk_Encryption_Howto_2019>
[wiki-luks]: <https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup>
[arch-wiki-encrypt-entire-fs]: <https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system>
[arch-wiki-device-encryption]: <https://wiki.archlinux.org/title/Dm-crypt/Device_encryption>
[arch-wiki-grub-encrypted-boot]: <https://wiki.archlinux.org/title/GRUB#Encrypted_/boot>
[cryptsetup-man-8]: <https://man.archlinux.org/man/cryptsetup.8.en>

### LVM

- [wiki-lvm][wiki-lvm]
- [arch-wiki-lvm][arch-wiki-lvm]

[wiki-lvm]: <https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)>
[arch-wiki-lvm]: <https://wiki.archlinux.org/title/LVM>

### Legacy installer + upgrade to the latest version

- [old-ubuntu-releases][old-ubuntu-releases]
- [how-to-upgrade-ubuntu-release][how-to-upgrade-ubuntu-release]
- [ubuntu-eof-upgrades][ubuntu-eof-upgrades]
- [ubuntu-meta-release][ubuntu-meta-release]

[old-ubuntu-releases]: <https://old-releases.ubuntu.com/releases/>
[how-to-upgrade-ubuntu-release]: <https://ubuntu.com/server/docs/how-to-upgrade-your-release>
[ubuntu-eof-upgrades]: <https://help.ubuntu.com/community/EOLUpgrades>
[ubuntu-meta-release]: <https://changelogs.ubuntu.com/meta-release>

### Snaps

- [baeldung-disable-snaps][baeldung-disable-snaps]

[baeldung-disable-snaps]: https://www.baeldung.com/linux/snap-remove-disable

