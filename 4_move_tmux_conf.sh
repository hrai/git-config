#!/bin/bash

if hash tmux 2>/dev/null; then
    echo 'Moving .tmux.conf to home directory....'
    cp .tmux.conf ~/.tmux.conf
    echo 'Successfully moved .tmux.conf to home directory....'

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    echo "Enter 'prefix + I' to install tmux plugins..."
else
    echo "Please install tmux to run this script."
fi
