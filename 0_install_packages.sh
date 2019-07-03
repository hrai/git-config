#!/bin/bash

################################################
############# function definitions #############
################################################

function install_package_mac_cask () {
    if brew cask ls --versions "$1" > /dev/null; then
        echo ">>>$1 is already installed"
    else
        brew cask install "$1"
    fi
}

function install_hack_nerd_font() {
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "Hack Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts%2FHack%2FRegular%2Fcomplete%2FHack%20Regular%20Nerd%20Font%20Complete.ttf
}

function install_aws_cli() {
    pip3 install awscli --upgrade --user
}

function install_ctags() {

    echo "Do you want to install and compile ctags (y/n)?"
    read user_response

    if [ "$user_response" = "y" ]
    then
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
            autojump
            curl
            dos2unix
            editorconfig
            git
            git-extras
            make
            nodejs
            python3-dev
            the_silver_searcher
            thefuck
            tmux
            tree
            zsh
        )

        install_mac_packages ${packages[@]}

        install_package_mac_cask "kdiff3"
        install_aws_cli

    elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        # disable Alt + F4 switching to TTY4
        sudo kbd_mode -s

        packages=(
            ack-grep
            autojump
            curl
            dos2unix
            editorconfig
            fonts-hack-ttf
            fonts-powerline
            git
            git-extras
            kdiff3
            libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev #vim build deps
            make
            nautilus
            nodejs
            python-dev
            python3-dev
            python3-pip
            python3-setuptools
            redshift-gtk
            silversearcher-ag
            tmux
            tree            
            xclip
            xdg-utils
            xsel
            zsh
        )

        install_linux_packages ${packages[@]}

        sudo pip3 install thefuck
        install_ctags
        install_aws_cli

        install_hack_nerd_font
    fi

    echo 'Finished installing apps....'
}

function is_linux() {
    local SYSTEM_NAME="$(expr substr $(uname -s) 1 5)"

    if [ "$SYSTEM_NAME" = "Linux" ]; then
        true
    else
        false
    fi
}

function is_windows() {
    local SYSTEM_NAME="$(expr substr $(uname -s) 1 10)"

    if [ "$SYSTEM_NAME" = "MINGW64_NT" ]; then
        true
    elif [ "$SYSTEM_NAME" = "MINGW32_NT" ]; then
        true
    else
        false
    fi
}

function create_ssh_key() {
    local ssh_file=~/.ssh/id_rsa

    if [ ! -f $ssh_file ]; then
        # create ssh keys
        echo -e "\n\n\n" | ssh-keygen -t rsa -b 4096 -C "rai.hangjit@gmail.com" -N ""
        eval "$(ssh-agent -s)"
        ssh-add $ssh_file
        xclip -sel clip < ~/.ssh/id_rsa.pub
        echo ">>>ssh file created and copied to clipboard."
    else
        echo ">>>$ssh_file already exists."
    fi
}

if ! is_windows; then
    install_apps
    create_ssh_key
fi

if is_linux; then
    # swap caps and escape
    dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

    # starting redshift-gtk
    echo "Starting redshift-gtk"
    sudo redshift-gtk

    echo "Do you want to move all sh files too (y/n)?"
    read user_response

    if [ "$user_response" = "y" ]
    then
        bash 1_move_all_dot_files.sh
    fi

    # set zsh as default shell
    echo "Setting zsh as default shell"
    chsh -s $(which zsh)
fi
