# Firefox

## Installation

Follow the instructions from [the guide][setup-firefox-developer-edition-on-ubuntu]:

1. [Download Firefox Developer Edition][firefox-developer-edition].
2. Unpack the downloaded archive to the `/opt` directory:
   ```shell
   sudo tar xjf firefox*.tar.bz2 -C /opt
   ```
3. Create a group that will own the installation and add the current user to the group:
   ```shell
   FIREFOX_GROUP="firefox"
   sudo groupadd "$FIREFOX_GROUP"
   sudo usermod -aG firefox "$USER"
   newgrp "$FIREFOX_GROUP"
   # If the last command does not work install shadow-utils or relogin to the account

   # After this, the current user must be have the firefox group
   groups "$USER"
   ```
3. Change the group ownership of the directory and allow the group to `rwx`:
   ```shell
   FIREFOX_GROUP="firefox"
   sudo chgrp -R "$FIREFOX_GROUP" /opt/firefox
   sudo chmod g=rwx -R /opt/firefox
   ```
4. Create a desktop entry:
   ```shell
   cat << EOF | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > ~/.local/share/applications/firefox_dev.desktop
   [Desktop Entry]
   Name=Firefox Developer 
   GenericName=Firefox Developer Edition
   Exec=/opt/firefox/firefox %u
   Terminal=false
   Icon=/opt/firefox/browser/chrome/icons/default/default128.png
   Type=Application
   Categories=Application;Network;X-Developer;
   Comment=Firefox Developer Edition Web Browser.
   StartupWMClass=Firefox Developer Edition
   EOF
   ```
5. Give the desktop entry file execute permissions:
   ```shell
   chmod +x ~/.local/share/applications/firefox_dev.desktop
   ```

## Extensions

- [Tree Style Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/).
- [Simple Tab Groups](https://addons.mozilla.org/en-US/firefox/addon/simple-tab-groups/).
- [Firefox Multi-Account Containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/).
- [I don't care about cookies](https://addons.mozilla.org/en-US/firefox/addon/i-dont-care-about-cookies/).
- [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/).
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin).
- [SponsorBlock](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/).
- [Unhook: Remove YouTube recommendations](https://addons.mozilla.org/en-US/firefox/addon/youtube-recommended-videos/).
- [YouTube NonStop](https://addons.mozilla.org/en-US/firefox/addon/youtube-nonstop/).
- [Vimium](https://addons.mozilla.org/en-CA/firefox/addon/vimium-ff).

## Disable tab bar

Follow the istructions from the Firefox support [forum][firefox-support-disable-tab-bar]:

1. Go to `about:support`.
2. Find the `Profile Directory` setting.
3. Ensure the following content is present in the `chrome/userChrome.css` under the `Profile Directory`:
   ```css
   /* Hide the native toolbar, because Tree Style Tab is in use */
   #TabsToolbar {
     visibility: collapse;
   }
   ```
4. Go to `about:config`.
5. Set the `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
6. Restart Firefox.

## Configuration checklist

- Go to the "Privacy & Security" tab and set proper settings.
- `Ctrl + Shift + B` to enable bookmarks.
- Enable extensions in private windows.
- Organize the toolbar and pin the necessary extensions.

## Useful links

- [firefox-developer-edition][firefox-developer-edition]
- [setup-firefox-developer-edition-on-ubuntu][setup-firefox-developer-edition-on-ubuntu]
- [firefox-support-disable-tab-bar][firefox-support-disable-tab-bar]

[firefox-developer-edition]: <https://www.mozilla.org/en-CA/firefox/developer/>
[setup-firefox-developer-edition-on-ubuntu]: <https://dev.to/harrsh/how-to-setup-firefox-developer-edition-on-ubuntu-4inp>
[firefox-support-disable-tab-bar]: <>https://support.mozilla.org/en-US/questions/1433369
