#!/bin/bash

echo 'Moving vim-files...'

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/hrai/vim-files/master/refresh_and_install_vimrcs.sh | sh

echo "Successfully moved vim-files to ~/.vim_runtime"

echo -e "\n"

echo "Press any key to continue..."
read
