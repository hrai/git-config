
#-----Command aliases-------
alias g='git'
alias x='exit'
alias v='vim'
alias ns='npm start'

#-------Git aliases-------
alias ga='g add'
alias gb='g branch'
alias gbD='g branch -D'
alias gbd='g branch -d'
alias gc='g clean -f'
alias gck='g checkout'
alias gckm='g checkout master'
alias gcm='g commit'
alias gd='g diff'
alias gf='g fetch --prune'
alias gm='g merge'
alias gmt='g mergetool'
alias gp='g pull'
alias gps='g push'
alias grs='g reset'
alias grb='g rebase'
alias grh='g reset --hard'
alias gs='g status'
alias gsa='g stash apply'
alias gsl='g stash list'
alias gsp='g stash pop'
alias gst='g stash'

#-------Delete all branches except master--------
alias gbDA='git branch | egrep -v "(master|\*)" | xargs git branch -D'
