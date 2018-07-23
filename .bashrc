#-----Command aliases-------
alias g='git'
alias x='exit'
alias v='vim'
alias ni='npm install'
alias ns='npm start'
alias cd..='cd ..'


#-------Git aliases-------
alias ga='g add'
alias gb='g branch'
alias gbD='g branch -D'
alias gbd='g branch -d'
alias gc='g clean -f' #remove untracked dirs and files
alias gck='g checkout'
alias gckb='g checkout -b'
alias gckm='g checkout master'
alias gcm='g commit'
alias gcl='g clone'
alias gd='g diff'
alias gdc='g diff --cached'
alias gf='g fetch --prune'
alias gi='g init'
alias gl='g log'
alias gm='g merge'
alias gmt='g mergetool'
alias gp='g pull'
alias gps='g push'
alias grs='g reset'
alias grb='g rebase'
alias grbom='g rebase origin/master'
alias grh='g reset --hard'
alias grhom='grh origin/master'
alias gs='g status'
alias gsa='g stash apply'
alias gsl='g stash list'
alias gsp='g stash pop'
alias gsd='g stash drop'
alias gsc='g stash clear' #clear all the stashes
alias gst='g stash'

# git bash function
gbr() {
	git checkout GM-$1 #checking out a branch
}

gnbr() {
	git checkout -b GM-$1 #checking out a new branch
}

gnbrs() {
	git checkout -b SM-$1 #checking out a branch
}

gbrs() {
	git checkout SM-$1 #checking out a branch
}
#-------Delete all branches except master--------
alias gbDA='git branch | egrep -v "(master|\*)" | xargs git branch -D'
