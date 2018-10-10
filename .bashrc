#!/bin/bash

#-----Internal Command aliases-------
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -a'
alias python=python3
alias v='vim'
alias clr='clear'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'

#-----External Command aliases-------
alias d='docker'
alias g='git'
alias x='exit'
alias ni='npm install'
alias ns='npm start'
alias nt='npm test'


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


# git bash function
function gbr() {
  git checkout feature/PEN-$1 #checking out a branch
}

function gnbr() {
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

#-------Delete all branches except master--------
alias gbDA='git branch | egrep -v "(master|\*)" | xargs git branch -D'


start_tmux () {
  # set shell to start up tmux by default 
  if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
  fi
}

if [ "$(uname)" == "Darwin" ]; then
  start_tmux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  start_tmux
  # elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  # Do something under 32 bits Windows NT platform
  # elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  # Do something under 64 bits Windows NT platform
fi
