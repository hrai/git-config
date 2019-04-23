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

function update_system () {
  if [ "$(uname)" = "Darwin" ]; then
    brew update
    brew upgrade
  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
  fi
}

################################################
############# function definitions #############
################################################

function prettify_json {
    if [ $# -gt 0 ];
        then
        for arg in $@
        do
            if [ -f $arg ];
                then
                less $arg | python -m json.tool > $arg
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

function gbr() {
  git checkout release/$1
}

function gnr() {
  git checkout release/$1
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

function gcap() {
  branch_name=$(git symbolic-ref -q HEAD);
  git add .;
  git commit --amend --no-edit;
  git push -u -f origin $branch_name;
}

function gpu() {
  branch_name=$(git symbolic-ref -q HEAD);
  git push --set-upstream origin $branch_name;
}

function af() {
  alias | grep $1
}

#----- Fuzzy finder function -------
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}


#-----Internal Command aliases-------
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto'
alias clr='clear'

#-----External Command aliases-------
alias dk='docker'
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
alias gdh='g diff HEAD'
alias gf='g fetch --prune'
alias gi='g init'
alias gl='g log'
alias gm='g merge'
alias gmt='g mergetool'
alias gps='g push'
alias gpf='g push -f'
alias gp='g pull'
alias grb='g rebase'
alias grba='g rebase --abort'
alias grbc='g rebase --continue'
alias grbod='g rebase origin/develop'
alias grbom='g rebase origin/master'
alias grbod='g rebase origin/develop'
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

