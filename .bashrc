
function start_tmux () {
  # set shell to start up tmux by default 
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
  fi
}

if [ "$(uname)" = "Darwin" ]; then
  start_tmux
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  start_tmux
  # elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
  # Do something under 32 bits Windows NT platform
  # elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
  # Do something under 64 bits Windows NT platform
fi

if [ "$(uname)" = "Darwin" ]; then
  # update the system
  brew update
  brew upgrade
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  # update the system
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y

# elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
# elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi


# function definitions
function install_package () {
  if ! dpkg -s "$1" > /dev/null; then
    sudo apt install "$1" -y
  fi
}

function install_package_mac () {
  if brew ls --versions "$1" > /dev/null; then
    echo ">>>$1 is already installed"
  else
    brew install "$1"
  fi
}

function install_package_mac_cask () {
  if brew cask ls --versions "$1" > /dev/null; then
    echo ">>>$1 is already installed"
  else
    brew cask install "$1"
  fi
}


function prettify_json {
    if [ $# -gt 0 ];
        then
        for arg in $@
        do
            if [ -f $arg ];
                then
                less $arg | python -m json.tool
            else
                echo "$arg" | python -m json.tool
            fi
        done
    fi
}

# git bash function
function gbf() {
  git checkout feature/PEN-$1
}

function gbb() {
  git checkout bugfix/PEN-$1
}

function gnb() {
  git checkout -b bugfix/PEN-$1 #checking out a new branch
}

function gnf() {
  git checkout -b feature/PEN-$1 #checking out a new branch
}

function gap() {
  branch_name=$(git symbolic-ref -q HEAD);
  git add .;
  git commit -m "$*";
  git push -u origin $branch_name;
}

function gcp() {
  branch_name=$(git symbolic-ref -q HEAD);
  git commit -m "$*";
  git push -u origin $branch_name;
}

function gcmm() {
  git commit -m "$*";
}

if [ "$(uname)" = "Darwin" ]; then
    brew install gnu-sed --with-default-names
    install_package_mac "python3"
    install_package_mac "ack"
    install_package_mac "curl"
    # install_package_mac "fonts-powerline"
    install_package_mac "git"
    install_package_mac "git-extras"
    install_package_mac_cask "kdiff3"
    install_package_mac "make"
    install_package_mac "python"
    install_package_mac "python3"
    install_package_mac "tree"
    install_package_mac "zsh"

    pip3 install thefuck
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then

    install_package "python3-dev"
    install_package "python3-pip"
    install_package "ack-grep"
    install_package "curl"
    install_package "fonts-powerline"
    install_package "git"
    install_package "git-extras"
    install_package "kdiff3"
    install_package "make"
    install_package "python"
    install_package "python3"
    install_package "tree"
    install_package "vim-gtk3"
    install_package "zsh"

    sudo pip3 install thefuck
    install_ctags

# elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
# elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi


#-----Internal Command aliases-------
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -a'

#-----External Command aliases-------
alias d='docker'
alias g='git'
alias x='exit'
alias ni='npm install'
alias ns='npm start'
alias nt='npm test'
alias v='vim'


#-------Git aliases-------
alias ga='g add'
alias gb='g branch'
alias gbD='g branch -D'
alias gbd='g branch -d'
alias gc='g clean -f' #remove untracked dirs and files
alias gck='g checkout'
alias gckb='g checkout -b'
alias gckd='g checkout develop'
alias gckm='g checkout master'
alias gcl='g clone'
alias gcm='g commit'
alias gca='g commit --amend'
alias gcrp='g cherry-pick'
alias gd='g diff'
alias gdc='g diff --cached'
alias gf='g fetch --prune'
alias gi='g init'
alias gl='g log'
alias gm='g merge'
alias gmt='g mergetool'
alias gps='g push'
alias gpf='g push -f'
alias gp='g pull'
alias grb='g rebase'
alias grbom='g rebase origin/master'
alias grh='g reset --hard'
alias grhom='grh origin/master'
alias grs='g reset --soft'
alias gs='g status'
alias gsa='g stash apply'
alias gsc='g stash clear' #clear all the stashes
alias gsd='g stash drop'
alias gsl='g stash list'
alias gsp='g stash pop'
alias gst='g stash'


#-------Delete all branches except master--------
alias gbDA='git branch | egrep -v "(master|\*)" | xargs git branch -D'


