# Scripts Fedora

A collection of shell scripts made for Fedora. It is compatible with bash and zsh.

## How to users

### Directly

You can use them directly on terminal with `wget` or `curl`:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/RenanSantos7/scripts_fedora/main/<script-name>.sh)

# or

bash <(wget -qO- https://raw.githubusercontent.com/RenanSantos7/scripts_fedora/main/<script-name>.sh)
```

## Scripts

### `creact`

Create a ReactJS project using [vite.js](https://vite.dev)

An argument is required to provide the app name.

###  `create-expo` 

Create a React Native project using [Expo](https://expo.dev) (template `blank-typescript`) 

An argument is required to provide the app name.

### `dnflist`

If no arguments was provided, list all apps installed with dnf.

If an argument was provided, it filters that list with the argument. 

Example:
```sh
⤷ dnflist vlc
vlc.x86_64                                           1:3.0.21-19.fc42                     <desconhecido>
vlc-cli.x86_64                                       1:3.0.21-19.fc42                     <desconhecido>
vlc-gui-qt.x86_64                                    1:3.0.21-19.fc42                     <desconhecido>
vlc-gui-skins2.x86_64                                1:3.0.21-19.fc42                     <desconhecido>
vlc-libs.x86_64                                      1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-ffmpeg.x86_64                             1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-gnome.x86_64                              1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-kde.x86_64                                1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-lua.x86_64                                1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-notify.x86_64                             1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-pipewire.x86_64                           3-5.fc42                             <desconhecido>
vlc-plugin-pulseaudio.x86_64                         1:3.0.21-19.fc42                     <desconhecido>
vlc-plugin-visualization.x86_64                      1:3.0.21-19.fc42                     <desconhecido>
vlc-plugins-base.x86_64                              1:3.0.21-19.fc42                     <desconhecido>
vlc-plugins-extra.x86_64                             1:3.0.21-19.fc42                     <desconhecido>
vlc-plugins-video-out.x86_64                         1:3.0.21-19.fc42                     <desconhecido>
```

### `fedoraPosInstall`

This is my Fedora pos-install. Use as a suggestion. It does the following things:
- setup Flathub;
- change LibreOffice to flatpak version
- install flatpaks:
   	- [Android Studio](https://flathub.org/apps/com.google.AndroidStudio);
   	- [Apostrophe](https://flathub.org/apps/org.gnome.gitlab.somas.Apostrophe);
   	- [Bitwarden](https://flathub.org/apps/com.bitwarden.desktop);
   	- [Blanket](https://flathub.org/apps/com.rafaelmardojai.Blanket);
   	- [Cartridges](https://flathub.org/apps/org.nickvision.cartridges);
   	- [Dconf Editor](https://flathub.org/apps/ca.desrt.dconf-editor);
   	- [Dev Toolbox](https://flathub.org/apps/me.iepure.devtoolbox);
   	- [Eyedropper](https://flathub.org/apps/com.github.finefindus.eyedropper);
   	- [Extensions Manager](https://flathub.org/apps/com.mattjakeman.ExtensionManager);
   	- [Flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal);
   	- [Foliate](https://flathub.org/apps/com.github.johnfactotum.Foliate);
   	- [Fotema](https://flathub.org/apps/app.fotema.Fotema);
   	- [Fragments](https://flathub.org/apps/de.haeckerfelix.Fragments);
   	- [Gear Lever](https://flathub.org/apps/io.github.giantpinkrobots.gearlever);
   	- [Heroic Games Launcher](https://flathub.org/apps/com.heroicgameslauncher.hgl);
   	- [LibreOffice](https://flathub.org/apps/org.libreoffice.LibreOffice);
   	- [LocalSend](https://flathub.org/apps/org.localsend.localsend_app);
   	- [Lorem](https://flathub.org/apps/org.nickvision.lorem);
   	- [Main Menu](https://flathub.org/apps/org.kde.kmenuedit);
   	- [Missions Center](https://flathub.org/apps/io.missioncenter.MissionCenter);
   	- [NormCap](https://flathub.org/apps/org.normcap.NormCap);
   	- [Obsidian](https://flathub.org/apps/md.obsidian.Obsidian);
   	- [ONLYOFFICE Desktop Editors](https://flathub.org/apps/org.onlyoffice.desktopeditors);
   	- [Parabolic](https://flathub.org/apps/rs.paraweb.parabolic);
   	- [PDF Arranger](https://flathub.org/apps/com.github.jeromerobert.pdfarranger);
   	- [Postman](https://flathub.org/apps/com.getpostman.Postman);
   	- [Shotwell](https://flathub.org/apps/org.gnome.Shotwell);
   	- [Smile](https://flathub.org/apps/io.github.giantpinkrobots.smile);
   	- [Todoist](https://flathub.org/apps/com.todoist.Todoist);
   	- [Warehouse](https://flathub.org/apps/io.github.flattool.Warehouse);
   	- [ZapZap](https://flathub.org/apps/br.com.twinforce.zapzap);
   	- [Zen Browser](https://flathub.org/apps/app.zen_browser.zen);
- Install apps with DNF:
   	- Visual Studio Code;
   	- fastfetch;
   	- git;
   	- gnome-tweaks;
   	- inkscape;
   	- Java;
   	- micro;
   	- Microsoft Edge;
   	- VLC;
   	- zsh;
- Setup ZSH (with oh-my-zsh);
- Setup Micro;
- Install NVM;
   	- install node 22;
    - install lastest LTS version of node;
   	- install lastest version of node.

### `flatrun`

Runs a flatpak with its name instead of its ID. If there is no app, it searches the repositories and lists the results.

### `gereapk`

Generates the APK of a React Native app named as `[APP_NAME]_[VERSION]`. It also increases the version number on `package.json`.

### `git-browse`

Browse to the git remote repository page.

### `git-commit`

An alias to `git add . && git commit -m`.

Not working properly.

### `list`

An alias to `ls -GhaiNg --group-directories-first`. Here are the flags explanation:
- `-G`: Enables colored output to distinguish file types;
- `-h`: Displays file sizes in a human-readable format (e.g., 1K, 234M).
- `-a`: Shows all files, including hidden ones (those starting with a dot).
- `-i`: Displays the inode number for each file.
- `-N`: Prints file names literally, without interpreting special characters.
- `-g`: Shows group information but omits the owner’s name.
- `--group-directories-first`: Lists directories before regular files.

Example:

```sh
⤷ list                          
PID     | Permissoes | Tam | Data modif | Nome
total 8,0K
26356427 drwxr-xr-x. 1   54 jun 23 12:13 .
   33037 drwxr-xr-x. 1  866 jun 23 11:34 ..
26356428 drwxr-xr-x. 1  188 jun 23 11:37 .git
26356639 drwxr-xr-x. 1  334 jun 23 12:13 scripts
26356492 -rw-r--r--. 1 1,1K jun 23 11:34 LICENSE
26356493 -rw-r--r--. 1 3,1K jun 23 12:05 README.md
```

### `rndoc`

Browse to React Native docs. Optionally pass a React Native component as argument to browse directly the its page.

### `setuprn`

After create a React Native app with react-native-community-cli, use this script to change it to yarn, setup prettier, configure git repository and open it with vscode.

### `sparedir`

Setup redirect in ReactJS projects deployed on Vercel or Netlify.