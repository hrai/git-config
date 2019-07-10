#!/bin/bash

echo 'Moving git hooks to .global-git-hooks directory....'
mkdir -p ~/.global-git-hooks

if [ "$(uname)" = "Darwin" ]; then
    cp prepare-commit-msg-mac ~/.global-git-hooks/prepare-commit-msg
else
    cp prepare-commit-msg ~/.global-git-hooks/prepare-commit-msg
fi

cp pre-commit ~/.global-git-hooks/pre-commit

chmod 777 ~/.global-git-hooks/prepare-commit-msg
chmod 777 ~/.global-git-hooks/pre-commit
echo 'Successfully moved git hooks to .global-git-hooks directory....'

# git hooks folder setup
echo -e '\nSetting the global git-hooks folder to ~/.global-git-hooks'
git config --global core.hooksPath ~/.global-git-hooks
echo 'Successfully set the global git-hooks folder to ~/.global-git-hooks\n'

git config --global core.editor vim
git config --global core.filemode false
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global credential.helper 'cache --timeout=3600'
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool kdiff3
git config --global user.email rai.hangjit@gmail.com
git config --global user.name "Hangjit Rai"

if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    git config --global core.autocrlf true
fi

echo "Do you want to move .gitignore file too (y/n)?"
read user_response

if [ "$user_response" = "y" ]
then
    cp .gitignore_global ~/.gitignore
    git config --global core.excludesfile '~/.gitignore'
    echo "Successfully moved .gitignore file to ~/.gitignore"
fi

echo -e "\n"

echo "Press any key to continue..."
read
