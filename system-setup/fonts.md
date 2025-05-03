# Fonts

## Nerd Fonts

### Installation

1. Shallow clone the repository:
   ```bash
   git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git
   cd ./nerd-fonts
   ```
2. Checkout the desired version:
   ```bash
   NERD_FONTS_VERSION="v3.2.1"
   git fetch --depth=1 origin "+refs/tags/${NERD_FONTS_VERSION}:refs/tags/${NERD_FONTS_VERSION}"
   git checkout "${NERD_FORNTS_VERSION}"
   ```
3. Install the fonts in the system:
   ```bash
   # System-wide installation (preferred over user-wide)
   sudo ./install.sh --install-to-system-path

   # User-wide installation
   ./install.sh
   ```

## Iosevka Aile & Etoile

### Installation

1. Download [Iosevka][iosevka] Aile and Etoile [Super TTC distributions][iosevka-packages-docs] from https://github.com/be5invis/Iosevka/releases.
2. Unzip the downloaded archives. Each will contain a directory with a single `.ttc` file.
3. [Create directories for the font under the `/usr/local/share/fonts` and copy the `.ttc` files there][arch-wiki-fonts]:
   ```bash
   sudo mkdir -p /usr/local/share/fonts/Iosevka{Aile,Etoile}
   sudo cp ./IosevkaAile.ttc /usr/local/share/fonts/IosevkaAile/
   sudo cp ./IosevkaEtoile.ttc /usr/local/share/fonts/IosevkaEtoile/
   ```
4. Update the fontconfig cache:
   ```bash
   fc-cache
   ```
5. You can delete the downloaded and unpackaed files after installing the fonts.

## Useful links

- [nerd-fonts-installation][nerd-fonts-installation]
- [iosevka][iosevka]
- [iosevka-packages-docs][iosevka-packages-docs]
- [arch-wiki-fonts][arch-wiki-fonts]
- [arch-wiki-font-config][arch-wiki-font-config]

[nerd-fonts-installation]: <https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script>
[iosevka]: <https://github.com/be5invis/Iosevka>
[iosevka-packages-docs]: <https://github.com/be5invis/Iosevka/blob/main/doc/PACKAGE-LIST.md>
[arch-wiki-fonts]: <https://wiki.archlinux.org/title/Fonts>
[arch-wiki-font-config]: <https://wiki.archlinux.org/title/Font_configuration>
