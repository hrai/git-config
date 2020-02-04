# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh

# install npm packages
NODE_MODULES_DIR=/usr/lib/node_modules

echo $NODE_MODULES_DIR
if [ -d "$NODE_MODULES_DIR" ]; then
    echo "Changing owner of $NODE_MODULES_DIR to $USER"

    sudo chown -R $USER $NODE_MODULES_DIR
    # sudo chown -R $USER /usr/bin
fi

npm install web-ext
npm install eslint
npm install jest-cli




