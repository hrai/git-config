#!/bin/zsh

if hash zsh 2>/dev/null; then
    # set zsh as default shell
    chsh -s $(which zsh)

    echo 'Cloning oh-my-zsh....'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo 'Successfully cloned oh-my-zsh....'

    echo 'Moving .zshrc to home directory....'
    cp .zshrc ~/.zshrc
    cat .bashrc >> ~/.zshrc
    echo "Successfully moved .zshrc to home directory...."

    export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
    if [ -z "$ZSH_CUSTOM" ]
    then
        echo "Cloning plugins to $ZSH_CUSTOM...."
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
        git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
        echo "Successfully cloned plugins to $ZSH_CUSTOM...."
    else
        echo ".zshrc doesn't exist or isn't loaded by zsh while cloning the plugins..."
    fi

    echo -e "\n"

    read -n 1 -s -r -p "Press any key to continue..."
else
    read -n 1 -s -r -p "Please install zsh to run this script."
fi
