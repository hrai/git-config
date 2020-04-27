if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    alias ls='ls --color=auto'
    alias cb='cd /mnt/c/_dev/cre-bus-fra/CREBusFra.Web'
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    alias cb='cd /c/_dev/cre-bus-fra/CREBusFra.Web'
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
    alias cb='cd /c/_dev/cre-bus-fra/CREBusFra.Web'
fi

################################################
############# function definitions #############
################################################

prettify_json() {
    if [ $# -gt 0 ];
        then
        for arg in $@
        do
            if [ -f $arg ];
                then
                python -m json.tool "$arg"
            else
                echo "$arg" | python -m json.tool | vim -
            fi
        done
    fi
}

# git bash function
gbf() {
  git checkout CRE-$1
}

gbb() {
  git checkout CRE-$1
}

gnb() {
  git checkout -b CRE-$1 #checking out a new branch
}

gnf() {
  git checkout -b CRE-$1 #checking out a new branch
}

gbr() {
  git checkout release/$1
}

gnr() {
  git checkout release/$1
}

get_branch_name() {
    branch_name=$(git symbolic-ref -q HEAD);
    echo $branch_name;
}

gac() {
  branch_name=$(get_branch_name);
  git add .;
  git commit -m "$*";
}

gap() {
  branch_name=$(get_branch_name);
  git add .;
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcp() {
  branch_name=$(get_branch_name);
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcmm() {
  git commit -m "$*";
}

gcap() {
  branch_name=$(get_branch_name);
  git add .;
  git commit --amend --no-edit;
  git push -u -f origin $branch_name;
}

gpu() {
  branch_name=$(get_branch_name);
  git push --set-upstream origin $branch_name;
}

grc() {
  branch_name=$(get_branch_name);
  git add .;
  git commit -m "review comments";
  git push -u origin $branch_name;
}

gco() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

fa() {
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
alias clr='clear'
alias rmf='rm -rf'
alias sbc='source ~/.bashrc'


#-----External Command aliases-------
alias dk='docker'
alias g='git'
alias x='exit'
alias ni='npm install'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias y='yarn'
alias ys='yarn start'

alias dn='dotnet'
alias db='dotnet build'
alias dr='dotnet run'
alias dt='dotnet test'

#-----Config file aliases-------
alias gconf='vim ~/.gitconfig'
alias gignore='vim ~/.gitignore'
alias vconf='vim ~/.vimrc'
alias bconf='vim ~/.bashrc'

#-------Git aliases-------
alias ga='git add'
alias gb='git branch'
alias gbD='git branch -D'
alias gbd='git branch -d'
alias gc='git clean -f' #remove untracked dirs and files
alias gca='git commit --amend'
alias gck='git checkout'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gct='git commit'
alias gcrp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gdp='git checkout develop && git pull'
alias gf='git fetch --prune'
alias gi='git init'
alias gl='git checkout -'
alias gls='git ls-files'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmm='git merge master'
alias gmp='git checkout master && git pull'
alias gmt='git mergetool'
alias gmv='git mv'
alias gp='git pull'
alias gpf='git push -f'
alias gps='git push'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbod='git rebase origin/develop'
alias grbod='git rebase origin/develop'
alias grbom='git rebase origin/master'
alias grh='git reset --hard'
alias grhom='git reset --hard origin/master'
alias grm='git rm'
alias grs='git reset --soft'
alias gs='git status'
alias gsa='git stash apply'
alias gsc='git stash clear' #clear all the stashes
alias gsd='git stash drop'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gst='git stash'

alias gcl='gap cleanup'


#-------Delete all branches except master--------
alias gbda='git branch | egrep -v "(master|\*)" | xargs git branch -D'

# AWS CLI path
export PATH=~/.local/bin:$PATH

# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

