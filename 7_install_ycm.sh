# install dependencies
sudo apt install build-essential cmake python3-dev python-dev npm -y

cd ~/.vim/plugged/YouCompleteMe

setup_cs_autocomplete() {
    wget http://download.mono-project.com/repo/xamarin.gpg
    sudo apt-key add xamarin.gpg -y
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee --append -y
    /etc/apt/sources.list.d/mono-xamarin.list
    sudo apt update -y
    sudo apt install mono-complete -y

    sudo certmgr -ssl -m https://go.microsoft.com -y
    sudo certmgr -ssl -m https://nugetgallery.blob.core.windows.net -y
    sudo certmgr -ssl -m https://nuget.org -y
    mozroots --import --sync -y

    sudo ./install.py --cs-completer
}

setup_js_autocomplete() {
    sudo npm install -g typescript
    sudo ./install.py --ts-completer
}


# http://ycm-core.github.io/YouCompleteMe/
# The following additional language support options are available:
#     C# support: install Mono and add --cs-completer when calling install.py.
#     Go support: install Go and add --go-completer when calling install.py.
#     JavaScript and TypeScript support: install Node.js and npm and add --ts-completer when calling install.py.
#     Rust support: install Rust and add --rust-completer when calling install.py.
#     Java support: install JDK8 (version 8 required) and add --java-completer when calling install.py.

setup_js_autocomplete
setup_cs_autocomplete
