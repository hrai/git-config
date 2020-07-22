#!/bin/bash

sudo add-apt-repository ppa:lyzardking/ubuntu-make
sudo apt-get update
sudo apt-get install ubuntu-make

umake web firefox-dev

FIREFOX=~/.local/share/umake/web/firefox-dev/firefox
if [[ -f "$FIREFOX" ]]; then
    ln -fs $FIREFOX ~/.local/bin/firefox-developer
fi
