echo 'Moving bashrc to home directory....'
sh move_bashrc.sh

echo ''
echo 'Moving git hooks to home directory....'
sh move_git_hooks.sh

echo ''
echo 'Moving tmux config to home directory....'
sh move_tmux_conf.sh

echo ''
echo 'Moving zshrc to home directory....'
sh move_zshrc.sh

echo ''
echo "Successfully moved dot files to home directory...."
