################################################
################## .zshrc ######################
################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
#
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

update_system () {
    if [ "$(uname)" = "Darwin" ]; then
        brew update
        brew upgrade
    elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt autoremove -y
    fi

    zinit update

    nvim --headless +PlugUpdate +UpdateRemotePlugins +qall
}

rgf() {
    rg $* | fpp
}


load_docker_config() {
    # auto completion
    zinit ice as"completion"
    zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
    # One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
    # This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
    # single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
    # select Linux package – in this case this is not needed, zinit will grep
    # operating system name and architecture automatically when there's no `bpick'

    zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zinit load docker/compose

    export DOCKER_HOST=tcp://localhost:2375

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
}

# set shell to start up tmux by default
export ZSH_TMUX_AUTOSTART=true

convert_to_mobi_and_delete() {
    for book in *.epub; do echo "Converting $book"; ebook-convert "$book" "$(basename "$book" .epub).mobi"; done && rm -f *.epub
    }


if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    alias ls='ls --color=auto'
fi

# ALIASES
alias fm=ranger

## Aliases for opening Github PRs
alias opm='open-pr master'
alias opd='open-pr develop'

alias zconf="vim ~/.zshrc"
alias szc='source ~/.zshrc'
alias zls='zinit ls'
alias ex='explorer.exe .'
alias tconf="vim ~/.tmux.conf"


# Suffix aliases
alias -s log=vim
alias -s notes=vim

# Ignoring cre-bus-fra build folders
# alias ag='ag --ignore-dir={wwwroot,dist}'
alias ag=rg --hidden

################################################
############# Sourcing zinit ###################
################################################
source ~/.zinit/bin/zinit.zsh

zinit light zinit-zsh/z-a-bin-gem-node

#
## Themes
##
zinit ice depth=1; zinit light romkatv/powerlevel10k



################################################
############# Oh-my-zsh plugins #############
################################################

setopt promptsubst

zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/correction.zsh
zinit snippet OMZ::lib/directories.zsh
zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/misc.zsh
zinit snippet OMZ::lib/nvm.zsh
zinit snippet OMZ::lib/spectrum.zsh
zinit snippet OMZ::plugins/git-extras/git-extras.plugin.zsh
zinit snippet OMZ::plugins/last-working-dir/last-working-dir.plugin.zsh
zinit snippet OMZ::plugins/npm/npm.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
zinit snippet OMZ::plugins/ubuntu/ubuntu.plugin.zsh
zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
zinit snippet OMZ::plugins/vscode/vscode.plugin.zsh
zinit snippet OMZ::plugins/web-search/web-search.plugin.zsh
# zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit snippet OMZP::gitignore
zinit snippet OMZP::jira
zinit snippet OMZP::thefuck
zinit snippet OMZP::vi-mode
zinit snippet OMZP::yarn

zinit ice as"completion"
zinit snippet OMZP::fd/_fd

################################################
################## apps #######################
################################################
# Binary release in archive, from Github-releases page; after automatic unpacking it provides program "fzf"
zinit ice from"gh-r" as"program" bpick"*amd64*"
zinit light junegunn/fzf-bin

zinit ice from"gh-r" as"program" bpick"*amd64*" mv"usr/bin/fd -> fd"
zinit light sharkdp/fd

zinit lucid as=program pick="$ZPFX/bin/fzf-tmux" \
        atclone=" cp bin/fzf-tmux $ZPFX/bin" \
            for junegunn/fzf

zinit ice as"program" pick"yank" make
zinit light mptre/yank

zinit ice as"program" pick"fasd" make"install"
zinit light clvv/fasd

# completions
# zinit cuninstall zsh-users/zsh-completions   # uninstall
# zinit creinstall zsh-users/zsh-completions   # install

zinit ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
zinit light k4rthik/git-cal

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zinit load trapd00r/LS_COLORS

zinit ice pick"init.sh"
zinit light b4b4r07/enhancd
export ENHANCD_DISABLE_DOT=1

zinit ice as"program" atload"fpath+=( \$PWD );" mv"wsl-open.sh -> wsl-open"
zinit light 4U6U57/wsl-open

# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light MichaelAquilina/zsh-you-should-use
zinit light momo-lab/zsh-abbrev-alias #abbrev-alias -g G="| grep"
zinit light wfxr/forgit
zinit light hlissner/zsh-autopair
zinit light peterhurford/git-it-on.zsh
zinit light caarlos0/zsh-open-pr
zinit light Aloxaf/fzf-tab

zinit light changyuheng/zsh-interactive-cd
zinit load zdharma/history-search-multi-word

zinit light kutsan/zsh-system-clipboard
ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT='true'

# install tmux
# zinit ice as"program" atclone"sh autogen.sh && ./configure" atpull"%atclone" make"install" pick"tmux/tmux"
# zinit light tmux/tmux

zinit ice as"program" cd"PathPicker/debian" atpull"./package.sh "  pick"facebook/PathPicker"
zinit light facebook/PathPicker

zplugin ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zinit as"null" wait"1" lucid for \
    sbin    cloneopts paulirish/git-open \
    sbin    paulirish/git-recent \
    sbin    davidosomething/git-my \
    sbin atload"export _MENU_THEME=legacy" \
    arzzen/git-quick-stats \
    sbin    iwata/git-now \
    sbin"bin/git-dsf;bin/diff-so-fancy" \
    zdharma/zsh-diff-so-fancy \
    sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" \
    zdharma/git-url

zinit ice from"gh-r" as"program" bpick"*linux*" mv"exa* -> exa"
zplugin light ogham/exa

zinit ice from"gh-r" as"program" bpick"*amd64.deb" mv"usr/bin/bat -> bat"
zplugin light sharkdp/bat

zinit as"completion" mv"c* -> _exa" for https://github.com/ogham/exa/blob/master/contrib/completions.zsh

# zinit ice blockf atload'zinit creinstall -q .'
zinit ice blockf atclone'zinit creinstall -q' atpull'%atclone'
zinit light zsh-users/zsh-completions

zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

#
# zinit ice from"gh-r" as"program" bpick"*linux_amd64*" mv"wtf*/wtfutil -> wtfutil"
# zinit light wtfutil/wtf

# zinit ice from"gh-r" as"program" bpick"*amd64.tar.gz"
# zinit light Versent/saml2aws


# install vim
# if is_not_mac; then
#     # Ice-mod `pick` selects a binary program to add to $PATH.
#     zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure --enable-gui=auto --enable-gtk2-check --with-x --prefix=/usr --enable-pythoninterp=yes --enable-python3interp=yes" atpull"%atclone" make pick"src/vim"
# else
#     zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure --with-features=huge --enable-multibyte  --enable-pythoninterp=yes --enable-python3interp=yes --enable-cscope --prefix=/usr/local" atpull"%atclone" make pick"src/vim"
# fi

# zinit light vim/vim
# export VIMRUNTIME=~/.zinit/plugins/vim---vim/runtime


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

# if is_not_mac; then
#     # source autojump starter file
#     . /usr/share/autojump/autojump.sh
# fi

# # for Mac
# [ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

# # autojump error fix - https://github.com/wting/autojump/issues/474
# unsetopt BG_NICE

export UPDATE_ZSH_DAYS=13

## Preferred editor for local and remote sessions
export EDITOR="nvim"
export VIMCONFIG="~/.config"

export SSH_KEY_PATH="~/.ssh/rsa_id"

export JIRA_URL='https://domain.atlassian.net'

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

if [[ $(compaudit) ]]; then
    # Fix for compinit (There are insecure directories)
    compaudit | xargs chown -R "$(whoami)"
    compaudit | xargs chmod -R go-w
fi


# instead of 'cd my_dir' you can do my_dir
setopt AUTO_CD

# Initialising zsh abbreviations plugin
abbrev-alias -i
abbrev-alias -g G="| rg"
abbrev-alias -g gcl="gap cleanup"
abbrev-alias -g ls="exa"

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
    alias j='fasd_cd -d'

    # Interactive cd
    abbrev-alias zz='fasd_cd -d -i'

    # Interactive open file in Vim
    abbrev-alias of='fasd -f -e vim'
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

#----- Fuzzy finder (fzf) functions -------

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

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() (
    IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)

    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
    fi
)


# ssh functions
load_work_ssh_settings() {
    eval "$(ssh-agent -s)"

    ssh-add -l
    ssh-add -D
    ssh-add ~/.ssh/id_rsa
}

load_personal_ssh_settings() {
    eval "$(ssh-agent -s)"

    ssh-add -l
    ssh-add -D
    ssh-add ~/.ssh/id_rsa_personal
}

fix_git_hooks_line_breaks() {
    dos2unix .git/hooks/pre*
}

# Forgit plugin config
forgit_reset_head=grhd


# Use it when fzf-tab doesn't initialize properly
enable-fzf-tab

if is_wsl; then
    # Adding wsl-open as a browser for Bash for Windows
    if [[ $(uname -r) == *Microsoft ]]; then
        if [[ -z $BROWSER ]]; then
            export BROWSER=wsl-open
        else
            export BROWSER=wsl-open:$BROWSER
        fi
    fi
fi

if is_program_installed 'bat'; then
    alias cat=bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export BAT_STYLE="full"
fi

# load_docker_config

autoload -Uz compinit
compinit

zinit cdreplay -q   # -q is for quiet; actually run all the `compdef's saved before
                    #`compinit` call (`compinit' declares the `compdef' function, so
                    # it cannot be used until `compinit' is ran; Zinit solves this
                    # via intercepting the `compdef'-calls and storing them for later
                    # use with `zinit cdreplay')

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
P10K=~/.p10k.zsh
[[ ! -f $P10K ]] || source $P10K && echo "$P10K sourced..."
