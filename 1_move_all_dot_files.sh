#!/bin/bash

# Moving bashrc to home directory....
bash 2_move_bashrc.sh

echo ''
# Moving zshrc to home directory....
bash 3_move_zshrc.sh

echo ''
# Moving tmux config to home directory....
bash 4_move_tmux_conf.sh

echo ''
# Moving git hooks to home directory....
bash 5_setup_git.sh

echo ''
# Moving vim-files to home directory....
bash 6_set_vim_configs.sh

echo ''
# Installing editor config....
bash 8_move_editorconfig.sh
