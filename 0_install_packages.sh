echo ''
echo 'Installing apps....'

if [ "$(uname)" == "Darwin" ]; then
    echo "Update 0_install_packages.sh file to include the packages to install."
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt install git
    sudo apt install python3
    sudo apt install zsh

# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
# elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi

echo ''
echo "Successfully installed the packages..."
