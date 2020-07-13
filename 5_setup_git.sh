#!/bin/bash

function create_ssh_key() {
    local ssh_file=~/.ssh/$1

    if [ ! -f $ssh_file ]; then
        # create ssh keys
        echo -e "\n\n\n" | ssh-keygen -f $ssh_file -t rsa -b 4096 -C "hangjit.rai@outlook.com" -N ""
        eval "$(ssh-agent -s)"
        ssh-add $ssh_file
        # xclip -sel clip < ~/.ssh/id_rsa.pub
        echo ">>>ssh file created and copied to clipboard."
    else
        echo ">>>$ssh_file already exists."
    fi
}

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

create_ssh_key 'id_rsa'
create_ssh_key 'id_rsa_personal'

echo 'Moving git hooks to .global-git-hooks directory....'
mkdir -p ~/.global-git-hooks/hooks

if [ "$(uname)" = "Darwin" ]; then
    cp git-hooks/prepare-commit-msg-mac ~/.global-git-hooks/hooks/prepare-commit-msg
else
    cp git-hooks/prepare-commit-msg ~/.global-git-hooks/hooks/prepare-commit-msg
fi

cp git-hooks/pre-commit ~/.global-git-hooks/hooks/pre-commit

cp .gitattributes ~/
echo "Successfully moved .gitattributes file to ~/.gitignore"

cp .gitignore_global ~/.gitignore
echo "Successfully moved .gitignore file to ~/.gitignore"

chmod 777 ~/.global-git-hooks/hooks/prepare-commit-msg
chmod 777 ~/.global-git-hooks/hooks/pre-commit
echo 'Successfully moved git hooks to .global-git-hooks directory....'

# git hooks folder setup
echo -e '\nSetting the global git-hooks folder to ~/.global-git-hooks'
# git config --global core.hooksPath ~/.global-git-hooks
echo 'Successfully set the global git-hooks folder to ~/.global-git-hooks\n'

echo 'Removing gitconfig file\n'
rm -rf ~/.gitconfig

git config --global core.editor vim
git config --global core.filemode false
git config --global core.ignorecase false
git config --global credential.helper 'cache --timeout=3600'
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool kdiff3
git config --global user.email hangjit.rai@outlook.com
git config --global user.name "Hangjit Rai"
git config --global init.templatedir '~/.global-git-hooks'
git config --global core.attributesfile '~/.gitattributes'

if is_windows; then
    git config --global core.autocrlf true
    git config --global credential.helper wincred
else
    git config --global core.autocrlf input
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

git config --global core.excludesfile '~/.gitignore'

