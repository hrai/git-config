## functions ##
is_wsl() {
    if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        true
    else
        false
    fi
}

is_program_installed() {
    if command -v $1 >/dev/null 2>&1; then
        true
    else
        false
    fi
}

is_not_mac() {
    if [ "$(uname)" != "Darwin"  ]; then
        true
    else
        false
    fi
}

hibernate() {
    systemctl suspend -i
}

# Sourcing zplugin
source ~/.zplugin/bin/zplugin.zsh

#
## Completions
##
zplugin ice as"completion"
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

#
## Scripts
##
zplugin ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
zplugin light k4rthik/git-cal

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

#
## Themes
##
zplugin ice from"gh"
zplugin load bhilburn/powerlevel9k


# Binary release in archive, from Github-releases page; after automatic unpacking it provides program "fzf"
zplugin ice from"gh-r" as"program" bpick"*amd64*"
zplugin light junegunn/fzf-bin

zplugin ice as"program" pick"yank" make
zplugin light mptre/yank

zplugin ice as"program" pick"fasd" make"install"
zplugin light clvv/fasd

# zplugin light nvbn/thefuck
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light paulirish/git-open
# zplugin light denysdovhan/spaceship-prompt
zplugin light MichaelAquilina/zsh-you-should-use
zplugin light momo-lab/zsh-abbrev-alias #abbrev-alias -g G="| grep"
zplugin light wfxr/forgit
zplugin light hlissner/zsh-autopair
zplugin light peterhurford/git-it-on.zsh
zplugin light caarlos0/zsh-open-pr

# Oh-my-zsh plugins
zplugin snippet OMZ::lib/clipboard.zsh
zplugin snippet OMZ::lib/correction.zsh
zplugin snippet OMZ::lib/directories.zsh
zplugin snippet OMZ::lib/functions.zsh
zplugin snippet OMZ::lib/history.zsh
zplugin snippet OMZ::lib/misc.zsh
zplugin snippet OMZ::lib/nvm.zsh
zplugin snippet OMZ::lib/spectrum.zsh
zplugin snippet OMZ::plugins/git-extras/git-extras.plugin.zsh
zplugin snippet OMZ::plugins/last-working-dir/last-working-dir.plugin.zsh
zplugin snippet OMZ::plugins/npm/npm.plugin.zsh
zplugin snippet OMZ::plugins/sudo/sudo.plugin.zsh
zplugin snippet OMZ::plugins/tmux/tmux.plugin.zsh
zplugin snippet OMZ::plugins/ubuntu/ubuntu.plugin.zsh
zplugin snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
zplugin snippet OMZ::plugins/vscode/vscode.plugin.zsh
zplugin snippet OMZ::plugins/web-search/web-search.plugin.zsh
zplugin snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin light changyuheng/zsh-interactive-cd
zplugin load zdharma/history-search-multi-word

zplugin light kutsan/zsh-system-clipboard
ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT='true'

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, Zplugin will grep
# operating system name and architecture automatically when there's no `bpick'

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zplugin load docker/compose

# zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command

if is_not_mac; then
    # Ice-mod `pick` selects a binary program to add to $PATH.
    zplugin ice as"program" atclone"rm -f src/auto/config.cache; ./configure --enable-gui=auto --enable-gtk2-check --with-x --prefix=/usr --enable-pythoninterp=yes --enable-python3interp=yes" atpull"%atclone" make pick"src/vim"
    zplugin light vim/vim

    export VIMRUNTIME=~/.zplugin/plugins/vim---vim/runtime
fi

# using case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# menu selection autocompletions and to have the words sorted by time
xdvi() { command xdvi ${*:-*.dvi(om[1])}  }
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time

# PLUGIN CONFIG

if is_not_mac; then
    # source autojump starter file
    . /usr/share/autojump/autojump.sh
fi

# for Mac
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

# autojump error fix - https://github.com/wting/autojump/issues/474
unsetopt BG_NICE

export DOCKER_HOST=tcp://localhost:2375
export UPDATE_ZSH_DAYS=13

## Preferred editor for local and remote sessions
export EDITOR="vim"

## ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# fzf command to honour gitignore
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.gitignore --nocolor --hidden -g ""'


# setting up thefuck plugin
eval $(thefuck --alias)

# setting up fasd plugin
eval "$(fasd --init auto)"

# LOADING ZSH CONFIG FILES
ZSH_DIR=~/.zsh
if [ -d $ZSH_DIR  ]; then
        print "Sourcing $ZSH_DIR folder..."

        for file in $ZSH_DIR/*; do
          source $file
          print $file
        done
else
        print "404: $ZSH_DIR folder not found."
fi

## Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

## Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

## Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk


if [[ $(compaudit) ]]; then
    # Fix for compinit (There are insecure directories)
    compaudit | xargs chown -R "$(whoami)"
    compaudit | xargs chmod -R go-w
fi


# instead of 'cd my_dir' you can do my_dir
setopt AUTO_CD

# Fasd
# If fasd is installed and in use, add a bunch of
# aliases for it.
if is_program_installed 'fasd'; then
    # https://dtw.io/writings/2017/dotfiles
    fasd_cache="$ZSH_CACHE_DIR/fasd-init-cache"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache


    # Any
    abbrev-alias a='fasd -a'

    # Show/search/select
    abbrev-alias s='fasd -si'

    # Directory
    abbrev-alias d='fasd -d'

    # File
    abbrev-alias f='fasd -f'

    # Interactive directory selection
    abbrev-alias sd='fasd -sid'

    # Interactive file selection
    abbrev-alias sf='fasd -sif'

    # cd - same functionality as j in autojump
    abbrev-alias z='fasd_cd -d'

    # Interactive cd
    abbrev-alias zz='fasd_cd -d -i'

    # Vim
    abbrev-alias vi='fasd -f -e vim'
fi

if is_program_installed 'wsl-open'; then
    abbrev-alias o='wsl-open'
fi

if is_wsl; then
    zplugin ice as"program" atload"fpath+=( \$PWD  );" mv"wsl-open.sh -> wsl-open"
    zplugin light 4U6U57/wsl-open

    # Adding wsl-open as a browser for Bash for Windows
    if [[ $(uname -r) == *Microsoft ]]; then
      if [[ -z $BROWSER ]]; then
        export BROWSER=wsl-open
      else
        export BROWSER=$BROWSER:wsl-open
      fi
    fi
fi

## Aliases for opening Github PRs
alias opm='open-pr master'
alias opd='open-pr develop'

alias zconf="vim ~/.zshrc"
alias zls='zplgin ls'
alias szc='source ~/.zshrc'

# Suffix aliases
alias -s log=vim
alias -s notes=vim


# print full file path
filepath() { for f in "$@"; do echo ${f}(:A); done  }

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

## powerlevel9k theme settings ##
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_HOME_ICON="\uf015 "
POWERLEVEL9K_HOME_SUB_ICON="\uf07c "
POWERLEVEL9K_FOLDER_ICON="\uf07c "
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# POWERLEVEL9K_DISABLE_RPROMPT=true
# POWERLEVEL9K_COLOR_SCHEME='light'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode time)

#----- Fuzzy finder (fzf) functions -------
# fshow - git commit browser
fcm() {
 git log --graph --color=always \
  ¦·--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
 fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
  ¦·--bind "ctrl-m:execute:
  ¦ ·¦ ·¦ ·(grep -o '[a-f0-9]\{7\}' | head -1 |
  ¦ ·¦ ·¦ ·xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
  ¦ ·¦ ·¦ ·{}
FZF-EOF"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

# fd - cd to selected directory
unalias fd
fd() {
 local dir
 dir=$(find ${1:-.} -path '*/\.*' -prune \
  ¦ ·¦ ·¦ ·¦·-o -type d -print 2> /dev/null | fzf +m) &&
 cd "$dir"
}

# fda - including hidden directories
fda() {
 local dir
 dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fkill - kill processes - list only the ones you can kill
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Select a docker container to start and attach to
da() {
    local cid
    cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

    [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
ds() {
    local cid
    cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

    [ -n "$cid" ] && docker stop "$cid"
}

# Forgit plugin config
forgit_reset_head=grhd

# Initialising zsh abbreviations plugin
abbrev-alias -i
