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

if ! [ -x "$(command -v nvm)" ]; then
    echo "Installing nvm.."
    if is_windows; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | sh
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh
    fi
fi

source ~/.nvm/nvm.sh

# install latest node version
nvm install node
nvm use node

# install npm packages
NODE_MODULES_DIR=/usr/lib/node_modules

echo $NODE_MODULES_DIR
if [ -d "$NODE_MODULES_DIR" ]; then
    echo "Changing owner of $NODE_MODULES_DIR to $USER"

    sudo chown -R $USER $NODE_MODULES_DIR
    # sudo chown -R $USER /usr/bin
fi

npm install -g web-ext
npm install -g eslint
npm install -g jest-cli
npm install -g bash-language-server
npm install -g sql-language-server
npm install -g tldr
npm install -g nb.sh #taking notes



