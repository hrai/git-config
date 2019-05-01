# install dependencies
sudo apt install build-essential cmake python3-dev

cd ~/.vim/plugged/YouCompleteMe

# The following additional language support options are available:
#     C# support: install Mono and add --cs-completer when calling install.py.
#     Go support: install Go and add --go-completer when calling install.py.
#     JavaScript and TypeScript support: install Node.js and npm and add --ts-completer when calling install.py.
#     Rust support: install Rust and add --rust-completer when calling install.py.
#     Java support: install JDK8 (version 8 required) and add --java-completer when calling install.py.
./install.py --ts-completer
