#!/bin/bash

source functions.sh

################################################
##################### Functions ################
################################################

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function install_package_mac_cask () {
    if brew cask ls --versions "$1" > /dev/null; then
        echo ">>>$1 is already installed"
    else
        brew cask install "$1"
    fi
}

function install_fira_code_nerd_font() {
    FONT_DIR=~/.local/share/fonts
    mkdir -p $FONT_DIR
    # cd ~/.local/share/fonts && curl -fLo "Hack Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FHack%2FRegular%2Fcomplete%2FHack%20Regular%20Nerd%20Font%20Complete.ttf
    curl -fLo "$FONT_DIR/Fira Code Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FFiraCode%2FRegular%2Fcomplete%2FFira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
}

function install_python_packages() {
    sudo pip3 install awscli --user
    sudo pip3 install thefuck --user
    sudo pip3 install ranger-fm --user
    sudo pip3 install pynvim --user --upgrade
}

function install_mac_firacode_nerdfont() {
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code
}

function install_docker() {
    if ! [ -x "$(command -v docker)" ]; then
        curl -fsSL https://get.docker.com -o ~/get-docker.sh
        sudo sh get-docker.sh
    fi
}

function install_dotnet() {
    wget -q https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb

    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install dotnet-sdk-3.1
}

function install_ctags() {
    if ! [ -x "$(command -v ctags)" ]; then
        sudo apt install "automake" -y
        sudo apt install "pkg-config" -y

        local CTAGS=~/ctags
        # clone if folder doesn't exist
        if [ ! -d "$CTAGS" ]; then
            git clone https://github.com/universal-ctags/ctags.git $CTAGS
        fi

        cd $CTAGS
        ./autogen.sh
        ./configure
        make
        sudo make install
    fi
}

function install_linux_packages() {
    arr=$@

    for i in ${arr[@]}; do
        if ! dpkg -s "$i" > /dev/null; then
            echo "Installing $i..."
            sudo apt install "$i" -y
        else
            echo ">>>$i is already installed"
        fi
    done
}

function install_mac_packages() {
    arr=$@

    for i in ${arr[@]}; do
        if brew ls --versions "$i" > /dev/null; then
            echo ">>>$i is already installed"
        else
            echo "Installing $i..."
            brew install "$i"
        fi
    done
}

function install_apps() {
    echo 'Installing apps....'
    # update packages
    if [ "$(uname)" = "Darwin" ]; then
        brew install gnu-sed --with-default-names

        xcode-select --install

        brew install --HEAD universal-ctags/universal-ctags/universal-ctags

        packages=(
            bat
            curl
            dos2unix
            editorconfig
            exa
            fd
            fzf
            git
            jq
            make
            navi
            neovim
            nodejs
            python3-dev
            ripgrep
            thefuck
            tmux
            tree
            zip
            zsh
        )

        install_mac_packages ${packages[@]}

        install_package_mac_cask "kdiff3"
        install_package_mac_cask "visual-studio-code"

        install_mac_firacode_nerdfont
        install_python_packages

    elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        # disable Alt + F4 switching to TTY4
        sudo kbd_mode -s

        sudo apt remove vim -y
        packages=(
            bat
            calibre
            curl
            cmake
            dos2unix
            editorconfig
            fd-find
            git
            jq
            kdiff3
            make
            python-dev
            python3-dev
            python3-pip
            python3-setuptools
            ranger
            redshift-gtk
            tmux
            tree
            torbrowser-launcher
            xclip
            xdg-utils
            xsel
            zip
            zsh
        )

        install_linux_packages ${packages[@]}

        install_ctags
        # install_docker
        install_dotnet
        install_fira_code_nerd_font

        install_python_packages
    fi


    echo 'Setting up JS env...'
    bash _install_nvm_and_setup_js.sh

    if is_linux; then
        echo 'Setting up kitty...'
        bash _install_kitty.sh
        bash _install_firefox_dev.sh

        packages=(
            transmission
        )

        install_linux_packages ${packages[@]}
    fi

    echo 'Finished installing apps....'
}

################################################
##################### End Functions ############
################################################

sudo apt update -y

if ! is_windows; then
    install_apps
fi

if is_wsl; then
    sudo apt install ubuntu-wsl -y
fi

if is_linux; then
    # swap caps and escape
    dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

    ZSH_CONF=~/.zshrc
    if ! [ -f "$ZSH_CONF" ]; then
        # starting redshift-gtk
        echo "Starting redshift-gtk"
        sudo redshift-gtk

        # set zsh as default shell
        echo "Setting zsh as default shell"
        chsh -s $(which zsh)
    fi
fi

cd $CURRENT_DIR

echo "Do you want to move all sh files too (y/n)?"
read user_response

if [ "$user_response" = "y" ]
then
    bash 1_move_all_dot_files.sh
fi


