#!/bin/bash

################################################
############# function definitions #############
################################################

function install_package () {
  if ! dpkg -s "$1" > /dev/null; then
    sudo apt install "$1" -y
  else
    echo ">>>$1 is already installed"
  fi
}

function install_package_mac () {
  if brew ls --versions "$1" > /dev/null; then
    echo ">>>$1 is already installed"
  else
    brew install "$1"
  fi
}

function install_package_mac_cask () {
  if brew cask ls --versions "$1" > /dev/null; then
    echo ">>>$1 is already installed"
  else
    brew cask install "$1"
  fi
}

function install_ctags() {

  echo "Do you want to install and compile ctags (y/n)?"
  read user_response

  if [ "$user_response" = "y" ]
  then
    install_package "automake"
    install_package "pkg-config"

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

function install_apps() {
  echo 'Installing apps....'
  # update packages
  if [ "$(uname)" = "Darwin" ]; then
      brew install gnu-sed --with-default-names

      xcode-select --install

      # install_package_mac "fonts-powerline"
      brew install --HEAD universal-ctags/universal-ctags/universal-ctags
      install_package_mac "ack"
      install_package_mac "autojump"
      install_package_mac "curl"
      install_package_mac "dos2unix"
      install_package_mac "editorconfig"
      install_package_mac "git"
      install_package_mac "git-extras"
      install_package_mac "caskroom/fonts/font-hack"
      install_package_mac "make"
      install_package_mac "npm"
      install_package_mac "python3-dev"
      install_package_mac "thefuck"
      install_package_mac "tmux"
      install_package_mac "tree"
      install_package_mac "zsh"
      install_package_mac_cask "kdiff3"

  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
      # disable Alt + F4 switching to TTY4
      sudo kbd_mode -s

      install_package "ack-grep"
      install_package "autojump"
      install_package "curl"
      install_package "dos2unix"
      install_package "editorconfig"
      install_package "fonts-powerline"
      install_package "fonts-hack-ttf"
      install_package "git"
      install_package "git-extras"
      install_package "kdiff3"
      install_package "make"
      install_package "npm"
      install_package "python-dev"
      install_package "python3-dev"
      install_package "python3-pip"
      install_package "python3-setuptools"
      install_package "redshift-gtk"
      install_package "tmux"
      install_package "tree"
      install_package "vim-gtk3"
      install_package "xclip"
      install_package "xsel"
      install_package "zsh"

      sudo pip3 install thefuck
      install_ctags
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
  sudo redshift-gtk

  echo "Do you want to move all sh files too (y/n)?"
  read user_response

  if [ "$user_response" = "y" ]
  then
    bash 1_move_all_sh.sh
    echo "Successfully moved sh files."
  fi

  # set zsh as default shell
  echo "Setting zsh as default shell"
  chsh -s $(which zsh)

fi
