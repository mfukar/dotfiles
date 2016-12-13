# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/michael.foukarakis/.oh-my-zsh

# Theme. See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes :
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=16

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# override the default umask:
umask 077

# Environment setup
#
# Homebrew:
export PATH="/usr/local/bin:${PATH}"
# Various stuff might be inside $HOME/bin/:
export PATH=${PATH}:${HOME}/bin
# Haskell stuff:
export PATH=${PATH}:~/Library/Haskell/bin
# Add RVM to PATH:
export PATH="$PATH:$HOME/.rvm/bin"

# Make less attempt to display raw chars:
export LESS="-r -X"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

__os=$(uname)


# Set aliases overriding those provided by oh-my-zsh.

if [[ $__os =~ "Darwin" ]]; then
    __vim="mvim -v"
else
    __vim="gvim -v"
fi
alias vim=$__vim

if [[ $__os =~ "Linux" ]]; then
    alias l='ls -lAFhG --color=auto'
else
    alias l='ls -lAFhG'
fi

alias peek='less -nU'
alias hexdump='hexdump -C'
alias golf='ruby ${HOME}/lib/golfscript.rb'
alias rm='rm -i'
alias grep="grep -n --color=auto --exclude-dir='.hg' --exclude-dir=\"target.*\""
alias egrep='grep -E'
alias ps='ps -ef'
# clang-format all .c files you come across:
alias clang-format-all='find `pwd` -iname "*.c" -exec sh -c "clang-format {} > /tmp/f && mv /tmp/f {}" \;'
# Alias for building with CMake out-of-source:
alias cmake-build='rm -rf ./build && mkdir -p build && pushd build && cmake .. && popd'

# Pygmentize systemd units and .ini files:
alias cat-ini='pygmentize -l ini'
alias cat-unit='cat-ini'

### Colours
#
# ls colors:
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"

# powerlevel9k colors:
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='00'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='136'
POWERLEVEL9K_DIR_HOME_BACKGROUND='09'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='09'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='009'
POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='236'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='236'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='119'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='196'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='005'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='236'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='245'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='236'

