#!/bin/bash	

# Verifica se o flatpak está instalado
if ! command -v flatpak &> /dev/null; then
	echo "Flatpak não encontrado. Instalando..."
	  sudo dnf install -y flatpak
fi

# Adiciona o repositório Flathub, se não existir
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Adicionado repositório do Flathub"

# Array com os IDs dos pacotes
appsFlatpak=(
	app.zen_browser.zen
	app.fotema.Fotema
	ca.desrt.dconf-editor
	com.bitwarden.desktop
	com.discordapp.Discord
	com.getpostman.Postman
	com.github.dynobo.normcap
	com.github.finefindus.eyedropper
	com.github.jeromerobert.pdfarranger
	com.github.johnfactotum.Foliate
	com.github.tchx84.Flatseal
	com.google.AndroidStudio
	com.heroicgameslauncher.hgl
	com.mattjakeman.ExtensionManager
	com.rafaelmardojai.Blanket
	com.rtosta.zapzap
	com.todoist.Todoist
	de.haeckerfelix.Fragments
	io.github.flattool.Warehouse
	io.gitlab.adhami3310.Converter
	io.missioncenter.MissionCenter
	it.mijorus.gearlever
	it.mijorus.smile
	md.obsidian.Obsidian
	me.iepure.devtoolbox
	page.codeberg.libre_menu_editor.LibreMenuEditor
	page.kramo.Cartridges
	org.gnome.eog
	org.gnome.design.Lorem
	org.gnome.gitlab.somas.Apostrophe
	org.gnome.Shotwell
	org.localsend.localsend_app
	org.nickvision.tubeconverter
	org.onlyoffice.desktopeditors    
)

# Instala os aplicativos do array
for app in "${appsFlatpak[@]}"; do
	  flatpak install -y flathub "$app" 
	  echo "Instalado: $app"
done

echo "✅ Flatpaks instalados"

# Adiciona a chave GPG da Microsoft
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Configura o repositório do Visual Studio Code
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Adiciona o repositório do Microsoft Edge
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge

# Instala pacotes via DNF
appsDnf=(
	code
	fastfetch
	git
	gnome-tweaks
	inkscape
	java-latest-openjdk
	micro
	microsoft-edge-stable
	vlc
	zsh
)

for app in "${appsDnf[@]}"; do
	sudo dnf install -y "$app" 
	echo "Instalado: $app"
done

echo "✅ Instalados apps com DNF"

# Trocar o shell para ZSH
touch $HOME/.zshrc 

chsh -s /usr/bin/zsh

# Baixar oh-my-zsh
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#
# ADICIONA CONFIGURAÇÕES NO FINAL DO ~/.zshrc
#
cat << 'EOF' | tee -a "$HOME/.zshrc" > /dev/null
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="renan"
zstyle ':omz:update' mode enabled
zstyle ':omz:update' mode auto
HIST_STAMPS="dd.mm.yyyy"
plugins=(git vscode zsh-autosuggestions dnf yarn)
source $ZSH/oh-my-zsh.sh
export EDITOR='micro'

# VARIÁVEIS DE AMBIENTE
export ANDROID_HOME=~/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/temurin-17-jdk
export PATH=$JAVA_HOME/bin:$PATH
GITHUB=/home/renan/GitHub
ONEDRIVE=/home/renan/OneDrive
OBSIDIAN=/home/renan/OneDrive/Documentos/Obsidian
SCRIPTS=/home/renan/.scripts
GALERIA="/home/renan/OneDrive/Imagens/Galeria Samsung"

# Carregar scripts executáveis do diretório $SCRIPTS
for script in "$SCRIPTS"/*; do
	if [ -f "$script" ] && [ -x "$script" ]; then
	  nome=$(basename "$script" .sh)
	  eval "
	  function $nome() {
	    source \"$script\"
	  }"
	fi
done

# Aliases personalizados
alias dnfu='sudo dnf update -y'
alias gedit='gnome-text-editor'
alias git-url='git remote get-url origin'
alias instdate='ls -lct --time-style="+%Y-%m-%d" ~ | tail -1 | awk "{print \$6}" | xargs -I{} date -d {} "+%d/%b/%Y"'
alias limpeGrd='cd android; ./gradlew clean; cd ..'
alias pn='pnpm'
alias sinctema='rsync -avr --delete ~/.local/share/icons/Meu\ tema/ $ONEDRIVE/Pública/Linux/Meu\ tema/'
alias ya='yarn android'
alias zshconf='$EDITOR ~/.zshrc'

EOF
exec zsh
echo "✅ zsh configurado"

#
#
#

mkdir -p "$HOME/.config/micro"
cat << 'EOF' | tee -a "$HOME/.config/micro/settings.json" > /dev/null

{
    "autosave": 3,
    "basename": true,
    "colorscheme": "atom-dark",
    "hlsearch": true,
    "keymenu": true,
    "softwrap": true,
    "wordwrap": true
}

EOF

echo "✅ configurado micro"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash 
echo "⬇️ baixado nvm"

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install 22 
nvm install --lts 
nvm install node 

sudo npm install --global yarn 
echo "✅ configurados nvm, node e yarn"


echo "===================================="
echo "Pós-instação concluída"
