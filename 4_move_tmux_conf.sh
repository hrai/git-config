if hash tmux 2>/dev/null; then
    echo 'Moving .tmux.conf to home directory....'
    cp .tmux.conf ~/.tmux.conf
    echo 'Successfully moved .tmux.conf to home directory....'

    echo -e "\n"

    read -n 1 -s -r -p "Press any key to continue..."
else
    read -n 1 -s -r -p "Please install tmux to run this script."
fi
