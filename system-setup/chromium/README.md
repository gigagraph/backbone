# Chromium

## Installation

1. [Download Chromium][download-chromium] for your platform.
2. Unpack the downloaded archive to the `/opt` directory:
3. Create a group that will own the installation and add the current user to the group:
   ```bash
   CHROMIUM_GROUP="chromium"
   sudo groupadd "${CHROMIUM_GROUP}"
   sudo usermod -aG "${CHROMIUM_GROUP}" "${USER}"
   newgrp "${CHROMIUM_GROUP}"
   # If the last command does not work install shadow-utils or relogin to the account

   # After this, the current user must be have the firefox group
   groups "${USER}"
   ```
3. Ensure that the sandbox binary name is `chrome-sandbox`:
   ```bash
   sudo mv /opt/chrome-linux/chrome_sandbox /opt/chrome-linux/chrome-sandbox
   ```
4. Change the group ownership of the directory and allow the group to `rwx`:
   ```bash
   CHROMIUM_GROUP="chromium"
   sudo chown -R root:root /opt/chrome-linux
   sudo chgrp -R "${CHROMIUM_GROUP}" /opt/chrome-linux
   sudo chmod u=rwx,g=rx,o=rx,u+s /opt/chrome-linux/chrome-sandbox
   ```
5. Create a desktop entry:
   ```bash
   chromium_desktop_entry_content="[Desktop Entry]
   Name=Chromium
   GenericName=Chromium
   Exec=/opt/chrome-linux/chrome %u
   Terminal=false
   Icon=/opt/chrome-linux/product_logo_48.png
   Type=Application
   Categories=Application;Network;X-Developer;
   Comment=Chromium Web Browser.
   StartupWMClass=Chromium
   EOF"

   echo "${chromium_desktop_entry_content}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > ~/.local/share/applications/chromium.desktop
   ```
5. Give the desktop entry file execute permissions:
   ```bash
   chmod +x ~/.local/share/applications/chromium.desktop
   ```

## Useful links

- [chromium-docs][chromium-docs].
- [download-chromium][download-chromium].

[chromium-docs]: https://www.chromium.org/chromium-projects/
[download-chromium]: https://download-chromium.appspot.com/

