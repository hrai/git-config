if hash zsh 2>/dev/null; then
    # set zsh as default shell
    chsh -s $(which zsh)

    # echo 'Cloning oh-my-zsh....'
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # echo 'Successfully cloned oh-my-zsh....'

    echo 'Moving .zshrc to home directory....'
    cp .zshrc ~/.zshrc
    cat .bashrc >> ~/.zshrc
    echo "Successfully moved .zshrc to home directory...."

    echo -e "\n"

    read -n 1 -s -r -p "Press any key to continue..."
else
    read -n 1 -s -r -p "Please install zsh to run this script."
fi
