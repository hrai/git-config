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
alias ytw='yarn test --watch'
alias ysc='yarn start:chrome'
alias fd='fd --ignore-file ~/.gitignore'
alias pip=pip3
alias python=python3

alias dn='dotnet'
alias db='dotnet build'
alias dr='dotnet run'
alias dt='dotnet test'

#-----Config file aliases-------
alias gconf='vim ~/.gitconfig'
alias gignore='vim ~/.gitignore'
alias vconf='vim ~/.vimrc'
alias bconf='vim ~/.bashrc'
alias ro='nb sync && nb open rough.notes'
alias vc='vim ~/.vim_runtime/my_configs.vim'


#-------Git aliases-------
alias ga='git add'
alias gb='git branch'
alias gbD='git branch -D'
alias gbd='git branch -d'
alias gc='git clean -f' #remove untracked dirs and files
alias gca='git commit --amend'
alias gck='git checkout'
alias gckb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gct='git commit'
alias gchp='git cherry-pick'
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
alias gms='git merge --skip'
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
alias grbs='git rebase --skip'
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
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    alias ls='ls --color=auto'

    alias cb='cd /mnt/c/_dev/cre-bus-fra/CREBusFra.Web'
# elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
elif [ "$(expr substr $(uname -s) 1 7)" = "MSYS_NT" ]; then
    alias cb='cd /c/_dev/cre-bus-fra/CREBusFra.Web'
fi

# fzf command to honour gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

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
    local branch_name=$(git symbolic-ref -q HEAD);
    echo $branch_name;
}

gac() {
  git add .;
  git commit -m "$*";
}

gap() {
  local branch_name=$(get_branch_name);
  git add .;
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcp() {
  local branch_name=$(get_branch_name);
  git commit -m "$*";
  git push -u origin $branch_name;
}

gcmm() {
  git commit -m "$*";
}

gcap() {
  local branch_name=$(get_branch_name);
  git add .;
  git commit --amend --no-edit;
  git push -u -f origin $branch_name;
}

gpu() {
  local branch_name=$(get_branch_name);
  git push --set-upstream origin $branch_name;
}

grc() {
  local branch_name=$(get_branch_name);
  git add .;
  git commit -m "addressed review comments";
  git push -u origin $branch_name;
}

gco() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

git_sync() {
    git fetch upstream
    git checkout master
    git merge upstream/master
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

# fd - cd to selected directory
fda() {
    local dir
    # dir=$(fd $1 --type d 2> /dev/null | fzf +m) && builtin cd "$dir"
    dir=$(fd $1 --type d | fzf +m) && builtin cd "$dir"
}

# fdh - including hidden directories
fdh() {
    local dir
    dir=$(fd $1 --type d --hidden | fzf +m) && builtin cd "$dir"
}

# fuzzy grep open via rg with line number
vg() {
    local file
    local line

    read -r file line <<<"$(rg --ignore-case --line-number $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

    if [[ -n $file ]]
    then
        vim +$line $file
    fi
}

# fh - repeat history
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | command sed -r 's/ *[0-9]*\*? *//' | command sed -r 's/\\/\\\\/g')
}

# checkout git branch
gbr() {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | command sed "s/.* //")
}

# AWS CLI path
export PATH=~/.local/bin:$PATH

# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

