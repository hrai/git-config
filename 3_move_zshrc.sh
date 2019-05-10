function is_windows() {
  local SYSTEM_NAME="$(expr substr $(uname -s) 1 10)"

  if [ "$SYSTEM_NAME" = "MINGW64_NT" ]; then
    true
  elif [ "$SYSTEM_NAME" = "MINGW32_NT" ]; then
    true
  else
    false
  fi
}

if hash zsh 2>/dev/null; then
    echo 'Cloning zplugin....'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
    echo 'Successfully cloned zplugin....'

    # securing the directories
    # sudo chmod -R 777 ~/.zplugin
    # sudo chown -R root:$USER ./.zplugin

    ZSH_DIR=~/.zsh
    echo "Moving key-bindings.zsh to $ZSH_DIR directory...."
    if [ ! -d $ZSH_DIR  ]; then
        mkdir $ZSH_DIR
        chmod 777 $ZSH_DIR
    fi

    cp key-bindings.zsh $ZSH_DIR/key-bindings.zsh
    echo "Successfully moved key-bindings.zsh to $ZSH_DIR directory...."

    cp powerlevel.zsh $ZSH_DIR/powerlevel.zsh
    echo "Successfully moved powerlevel.zsh to $ZSH_DIR directory...."

    ZSHRC=.zshrc
    echo "Moving $ZSHRC to home directory...."
    cp .bashrc ~/$ZSHRC
    cat $ZSHRC >> ~/$ZSHRC
    echo "Successfully moved $ZSHRC to home directory...."

    if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        echo '
        # Launch Zsh if it exists - for WSL
        if [ -t 1  ] && [ -x "$(command -v zsh)"  ]; then
          exec zsh
        fi
        ' >> ~/.bashrc
    fi

    echo 'Moving .zshenv to home directory....'
    cp .zshenv ~/.zshenv
    mkdir -p ~/.zsh/cache
    chmod 777 ~/.zsh/cache
    echo "Successfully moved .zshenv to home directory...."

    echo -e "\n"

    echo "Press any key to continue..."
    read
else
    echo "Please install zsh to run this script."
fi
