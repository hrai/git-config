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
    install_package "automake"
    install_package "pkg-config"

    local CTAGS=~/ctags
    # clone if folder doesn't exist
    if [ ! -d "$CTAGS" ]; then
      git clone https://github.com/universal-ctags/ctags.git $CTAGS
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
      install_package_mac "python3"
      install_package_mac "ack"
      install_package_mac "curl"
      # install_package_mac "fonts-powerline"
      install_package_mac "git"
      install_package_mac "git-extras"
      install_package_mac_cask "kdiff3"
      install_package_mac "make"
      install_package_mac "python"
      install_package_mac "python3"
      install_package_mac "tree"
      install_package_mac "zsh"
      install_package_mac "thefuck"
      install_package_mac "tmux"

      install_package_mac "--HEAD universal-ctags/universal-ctags/universal-ctags"
  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
      # disable Alt + F4 switching to TTY4
      sudo kbd_mode -s

      install_package "python3-dev"
      install_package "python3-pip"
      install_package "ack-grep"
      install_package "curl"
      install_package "fonts-powerline"
      install_package "git"
      install_package "git-extras"
      install_package "kdiff3"
      install_package "make"
      install_package "python"
      install_package "python3"
      install_package "tree"
      install_package "vim-gtk3"
      install_package "zsh"
      install_package "tmux"

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

if ! is_windows; then
    install_apps
fi

if is_linux; then
  # swap caps and escape
  dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"

  echo "Do you want to move all sh files too (y/n)?"
  read user_response

  if [ "$user_response" = "y" ]
  then
      bash 1_move_all_sh.sh
      echo "Successfully moved sh files."
  fi
fi
