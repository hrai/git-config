#!/bin/bash

function install_kitty() {
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
}

function setup_kitty_desktop_file() {
    # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in your PATH)
    ln -fs ~/.local/kitty.app/bin/kitty ~/.local/bin/

    # Place the kitty.desktop file somewhere it can be found by the OS
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications

    # Update the path to the kitty icon in the kitty.desktop file
    sed -i "s/Icon\=kitty/Icon\=\/home\/$USER\/.local\/kitty.app\/share\/icons\/hicolor\/256x256\/apps\/kitty.png/g" ~/.local/share/applications/kitty.desktop
}

function move_kitty_conf() {
    KITTY_CONFIG_PATH=~/.config/kitty
    mkdir -p $KITTY_CONFIG_PATH
    cp kitty.conf $KITTY_CONFIG_PATH/kitty.conf
}

function change_default_terminal_to_kitty() {
    # change default terminal emulator in Ubuntu to Kitty
    gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'
}

function install_and_configure_kitty() {
    install_kitty

    setup_kitty_desktop_file

    move_kitty_conf

    change_default_terminal_to_kitty
}

install_and_configure_kitty
