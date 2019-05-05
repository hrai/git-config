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

# Binary release in archive, from Github-releases page; after automatic unpacking it provides program "fzf"
zplugin ice from"gh-r" as"program" bpick"*amd64*"
zplugin light junegunn/fzf-bin

zplugin ice as"program" pick"yank" make
zplugin light mptre/yank

# zplugin light nvbn/thefuck
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light paulirish/git-open
zplugin light denysdovhan/spaceship-prompt
zplugin light MichaelAquilina/zsh-you-should-use
zplugin light momo-lab/zsh-abbrev-alias #abbrev-alias -g G="| grep"
zplugin light wfxr/forgit

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
#zplugin snippet OMZ::plugins/npm/npm.plugin.zsh
zplugin snippet OMZ::plugins/sudo/sudo.plugin.zsh
zplugin snippet OMZ::plugins/tmux/tmux.plugin.zsh
zplugin snippet OMZ::plugins/ubuntu/ubuntu.plugin.zsh
zplugin snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
zplugin snippet OMZ::plugins/vscode/vscode.plugin.zsh
zplugin snippet OMZ::plugins/web-search/web-search.plugin.zsh
zplugin snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin load zdharma/history-search-multi-word

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, Zplugin will grep
# operating system name and architecture automatically when there's no `bpick'

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zplugin load docker/compose

# zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command

# Vim repository on Github – a typical source code that needs compilation – Zplugin
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH.

# zplugin ice as"program" atclone"rm -f src/auto/config.cache; ./configure" atpull"%atclone" make pick"src/vim"
# zplugin light vim/vim

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

# source autojump starter file
. /usr/share/autojump/autojump.sh

# for Mac
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

# autojump error fix - https://github.com/wting/autojump/issues/474
unsetopt BG_NICE

export DOCKER_HOST=tcp://localhost:2375

# setting up thefuck plugin
eval $(thefuck --alias)

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

## If you come from bash you might have to change your $PATH.
## export PATH=$HOME/bin:/usr/local/bin:$PATH

## Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh
#export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

## Set list of themes to pick from when loading at random
## Setting this variable when ZSH_THEME=random will cause zsh to load
## a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
## If set to an empty array, this variable will have no effect.
## ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

## Uncomment the following line to use case-sensitive completion.
## CASE_SENSITIVE="true"

## Uncomment the following line if you want to disable marking untracked files
## under VCS as dirty. This makes repository status check for large repositories
## much, much faster.
## DISABLE_UNTRACKED_FILES_DIRTY="true"

## Uncomment the following line if you want to change the command execution time
## stamp shown in the history command output.
## You can set one of the optional three formats:
## "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
## or set a custom format using the strftime function format specifications,
## see 'man strftime' for details.
## HIST_STAMPS="mm/dd/yyyy"

## User configuration
## export MANPATH="/usr/local/man:$MANPATH"

## You may need to manually set your language environment
## export LANG=en_US.UTF-8


ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW="false"

## Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

export UPDATE_ZSH_DAYS=13

## Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

## Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

## ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

alias zshconfig="vim ~/.zshrc"


### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk


if [[ $(compaudit) ]]; then
	# securing directories
	compaudit | xargs chmod g-w
fi

alias zls='zplg ls'

# Suffix aliases
alias -s log=vim
alias -s notes=vim

## Preferred editor for local and remote sessions
export EDITOR="vim"

# instead of 'cd my_dir' you can do my_dir
setopt AUTO_CD


