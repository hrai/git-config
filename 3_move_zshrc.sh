if hash zsh 2>/dev/null; then
    # set zsh as default shell
    chsh -s $(which zsh)

    echo 'Cloning zplugin....'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    echo 'Successfully cloned zplugin....'

    # securing the directories
    # sudo chmod -R 777 ~/.zplugin
    # sudo chown -R root:$USER ./.zplugin

    echo 'Moving .zshrc to home directory....'
    cp .bashrc ~/.zshrc
    cat .zshrc >> ~/.zshrc
    echo "Successfully moved .zshrc to home directory...."


    echo 'Moving .zshenv to home directory....'
    cp .zshenv ~/.zshenv
    mkdir -p ~/.zsh/cache
    chmod 777 ~/.zsh/cache
    echo "Successfully moved .zshenv to home directory...."

    echo -e "\n"

    read -n 1 -s -r -p "Press any key to continue..."
else
    read -n 1 -s -r -p "Please install zsh to run this script."
fi
