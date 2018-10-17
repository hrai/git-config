#!/bin/bash

echo 'Moving prepare-commit-msg to .global-git-hooks directory....'
mkdir -p ~/.global-git-hooks
cp prepare-commit-msg ~/.global-git-hooks/prepare-commit-msg
chmod 777 ~/.global-git-hooks/prepare-commit-msg
echo 'Successfully moved prepare-commit-msg to .global-git-hooks directory....'

# git hooks folder setup
echo -e '\nSetting the global git-hooks folder to ~/.global-git-hooks'
git config --global core.hooksPath ~/.global-git-hooks
echo 'Successfully set the global git-hooks folder to ~/.global-git-hooks'

# global git config setup
git config --global credential.helper 'cache --timeout=3600'
git config --global --add merge.tool kdiff3

echo "Do you want to move .gitignore file too (y/n)?"
read user_response

if [ "$user_response" = "y" ]
then
    cp .gitignore_global ~/.gitignore
    git config --global core.excludesfile '~/.gitignore'
    echo "Successfully moved .gitignore file to ~/.gitignore"
fi

echo -e "\n"

read -n 1 -s -r -p "Press any key to continue..."
