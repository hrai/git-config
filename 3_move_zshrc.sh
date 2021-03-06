if hash zsh 2>/dev/null; then
    source functions.sh

    echo 'Cloning zinit....'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    echo 'Successfully cloned zinit....'

    # securing the directories
    # sudo chmod -R 777 ~/.zinit
    # sudo chown -R root:$USER ./.zinit

    ZSH_DIR=~/.zsh
    echo "Moving key-bindings.zsh to $ZSH_DIR directory...."
    if [ ! -d $ZSH_DIR  ]; then
        mkdir $ZSH_DIR
        chmod 777 $ZSH_DIR
    fi

    cp key-bindings.zsh $ZSH_DIR/key-bindings.zsh
    echo "Successfully moved key-bindings.zsh to $ZSH_DIR directory...."

    # cp powerlevel.zsh $ZSH_DIR/
    # echo "Successfully moved powerlevel.zsh to $ZSH_DIR directory...."

    cp .p10k.zsh $HOME
    echo "Successfully moved .p10k.zsh to $HOME directory...."

    ZSHRC=.zshrc
    echo "Moving $ZSHRC to home directory...."
    > ~/$ZSHRC # create/overwrite existing file
    cat functions.sh >> ~/$ZSHRC
    cat .bashrc >> ~/$ZSHRC
    cat $ZSHRC >> ~/$ZSHRC

    echo "Successfully moved $ZSHRC to home directory...."

    echo "Setting zsh as default shell...."
    chsh -s $(which zsh)

    if is_wsl; then
        cp .bashrc ~/.bashrc
        # echo '
        # # Launch Zsh if it exists - for WSL
        # if [ -t 1  ] && [ -x "$(command -v zsh)"  ]; then
        #   exec zsh
        # fi
        # ' >> ~/.bashrc
    fi

    echo 'Moving .zshenv to home directory....'
    cp .zshenv ~/.zshenv
    mkdir -p ~/.zsh/cache
    chmod 777 ~/.zsh/cache
    echo "Successfully moved .zshenv to home directory...."
else
    echo "Please install zsh to run this script."
fi
