#!/bin/sh

echo ''
echo 'Installing apps....'

function install_ctags() {
    git clone https://github.com/universal-ctags/ctags.git ~/ctags
    cd ~/ctags
    ./autogen.sh 
    ./configure
    make
    sudo make install
}

if [ "$(uname)" == "Darwin" ]; then
    echo "Update 0_install_packages.sh file to include the packages to install."
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt install git -y
    sudo apt install python3 -y
    sudo apt install zsh -y
    sudo apt install vim-gtk3 -y
    install_ctags

# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi

echo ''
echo "Successfully installed the packages..."
