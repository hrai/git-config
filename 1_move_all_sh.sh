echo 'Moving bashrc to home directory....'
bash 2_move_bashrc.sh

echo ''
echo 'Moving git hooks to home directory....'
bash 5_move_git_hooks.sh

echo ''
echo 'Moving tmux config to home directory....'
bash 4_move_tmux_conf.sh

echo ''
echo 'Moving zshrc to home directory....'
bash 3_move_zshrc.sh

echo ''
echo 'Moving vim-files to home directory....'
bash 6_set_vim_configs.sh

echo ''
echo "Successfully moved dot files to home directory...."
