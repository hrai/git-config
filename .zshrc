alias zls='zplg ls'

export EDITOR="vim"

# instead of 'cd my_dir' you can do my_dir
setopt AUTO_CD

if [[ $(compaudit) ]]; then
	# securing directories
	compaudit | xargs chmod g-w
fi

## If you come from bash you might have to change your $PATH.
## export PATH=$HOME/bin:/usr/local/bin:$PATH

## Path to your oh-my-zsh installation.
#export ZSH=$HOME/.oh-my-zsh
#export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

## Set name of the theme to load --- if set to "random", it will
## load a random theme each time oh-my-zsh is loaded, in which case,
## to know which specific one was loaded, run: echo $RANDOM_THEME
## See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"

## Set list of themes to pick from when loading at random
## Setting this variable when ZSH_THEME=random will cause zsh to load
## a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
## If set to an empty array, this variable will have no effect.
## ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

## Uncomment the following line to use case-sensitive completion.
## CASE_SENSITIVE="true"

## Uncomment the following line to use hyphen-insensitive completion.
## Case-sensitive completion must be off. _ and - will be interchangeable.
## HYPHEN_INSENSITIVE="true"

## Uncomment the following line to disable bi-weekly auto-update checks.
## DISABLE_AUTO_UPDATE="true"

## Uncomment the following line to change how often to auto-update (in days).
## export UPDATE_ZSH_DAYS=13

## Uncomment the following line to disable colors in ls.
## DISABLE_LS_COLORS="true"

## Uncomment the following line to disable auto-setting terminal title.
## DISABLE_AUTO_TITLE="true"

## Uncomment the following line to enable command auto-correction.
## ENABLE_CORRECTION="true"

## Uncomment the following line to display red dots whilst waiting for completion.
## COMPLETION_WAITING_DOTS="true"

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

## Would you like to use another custom folder than $ZSH/custom?
## ZSH_CUSTOM=/path/to/new-custom-folder

## Which plugins would you like to load?
## Standard plugins can be found in ~/.oh-my-zsh/plugins/*
## Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
## Example format: plugins=(rails git textmate ruby lighthouse)
## Add wisely, as too many plugins slow down shell startup.
#plugins=(
#  # git#  vi-mode
#  zsh-syntax-highlighting
#  zsh-autosuggestions
#  git-extras
#  last-working-dir
#  npm
#  sudo
#  tmux
#  vscode
#  web-search
#)

#source $ZSH/oh-my-zsh.sh

## User configuration

## export MANPATH="/usr/local/man:$MANPATH"

## You may need to manually set your language environment
## export LANG=en_US.UTF-8

## Preferred editor for local and remote sessions
## if [[ -n $SSH_CONNECTION ]]; then
##   export EDITOR='vim'
## else
##   export EDITOR='mvim'
## fi

## Compilation flags
## export ARCHFLAGS="-arch x86_64"

## ssh
## export SSH_KEY_PATH="~/.ssh/rsa_id"

## Set personal aliases, overriding those provided by oh-my-zsh libs,
## plugins, and themes. Aliases can be placed here, though oh-my-zsh
## users are encouraged to define aliases within the ZSH_CUSTOM folder.
## For a full list of active aliases, run `alias`.
##
## Example aliases
## alias zshconfig="mate ~/.zshrc"
## alias ohmyzsh="mate ~/.oh-my-zsh"

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin load zdharma/history-search-multi-word

zplugin ice compile"*.lzui" from"notabug"
zplugin load zdharma/zui

# Binary release in archive, from Github-releases page; after automatic unpacking it provides program "fzf"

zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, Zplugin will grep
# operating system name and architecture automatically when there's no `bpick'

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zplugin load docker/compose

# Vim repository on Github – a typical source code that needs compilation – Zplugin
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH.

# zplugin ice as"program" atclone"rm -f src/auto/config.cache; ./configure" atpull"%atclone" make pick"src/vim"
# zplugin light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make"" ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

# Two regular plugins loaded in default way (no `zplugin ice ...` modifiers)

# setting up thefuck plugin
eval $(thefuck --alias)

# zplugin light nvbn/thefuck
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-completions
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light paulirish/git-open
zplugin light denysdovhan/spaceship-prompt
zplugin light MichaelAquilina/zsh-you-should-use

# Load the pure theme, with zsh-async library that's bundled with it
# zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# This one to be ran just once, in interactive session

# zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command

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

# using case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

ZSH_THEME="spaceship"
SPACESHIP_BATTERY_SHOW="false"

# source autojump starter file
. /usr/share/autojump/autojump.sh

# fzf mapping
bindkey -s '^f' 'v $(fzf)\n'

export DOCKER_HOST=tcp://localhost:2375
