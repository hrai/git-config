echo 'Moving prepare-commit-msg to .global-git-hooks directory....'
mkdir -p ~/.global-git-hooks
cp prepare-commit-msg ~/.global-git-hooks/prepare-commit-msg
echo 'Successfully moved prepare-commit-msg to .global-git-hooks directory....'

echo -e '\nSetting the global git-hooks folder to ~/.global-git-hooks'
git config --global core.hooksPath ~/.global-git-hooks
echo 'Successfully set the global git-hooks folder to ~/.global-git-hooks'

echo -e "\n"

read -n 1 -s -r -p "Press any key to continue..."
