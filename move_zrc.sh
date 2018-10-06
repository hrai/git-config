echo 'Moving .zshrc to home directory....'
cat .bashrc >> ~/.zshrc
echo 'Successfully moved .zshrc to home directory....'

echo 'Cloning plugins to $ZSH_CUSTOM....'
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo 'Successfully moved .zshrc to home directory....'

echo -e "\n"

read -n 1 -s -r -p "Press any key to continue..."
