#!/bin/sh

echo 'Moving prepare-commit-msg to .global-git-hooks directory....'
mkdir -p ~/.global-git-hooks
cp prepare-commit-msg ~/.global-git-hooks/prepare-commit-msg
echo 'Successfully moved prepare-commit-msg to .global-git-hooks directory....'

echo -e '\nSetting the global git-hooks folder to ~/.global-git-hooks'
git config --global core.hooksPath ~/.global-git-hooks
echo 'Successfully set the global git-hooks folder to ~/.global-git-hooks'

echo "Do you want to move .gitignore file too (y/n)?"
read user_response

if [ "$user_response" = "y" ]
then
    cp .gitignore_global ~/.gitignore
    echo "Successfully moved .gitignore file to ~/.gitignore"
fi

echo -e "\n"

read -n 1 -s -r -p "Press any key to continue..."
