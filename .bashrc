# .bashrc

# source global definitions:
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

__os=$(uname)

if [ $__os = "Darwin" ]; then
    __vim="mvim -v"
else
    __vim="gvim -v"
fi

# override the default umask:
umask 077

export EDITOR=$__vim
export HG_EDITOR=$__vim

# common environment aliases (mfukar):
if [ $__os = "Linux" ]; then
    alias l='ls -lAFhG --color=auto'
else
    alias l='ls -hlAFG'
fi

alias peek='less -nU'
alias tail='less -nUEX +F'
alias hexdump='hexdump -C'
alias golf='ruby ${HOME}/lib/golfscript.rb'
alias rm='rm -i'
alias grep="grep -n --color=auto --exclude-dir='.hg' --exclude-dir=\"target.*\""
alias egrep='grep -E'
alias ps='ps -ef'
alias vim=$__vim
# Linux style:
#   -nbad -bap -nbc -bbo -hnl -br -brs -c33 -cd33 -ncdb -ce -ci4
#   -cli0 -d0 -di1 -nfc1 -i8 -ip0 -l80 -lp -npcs -nprs -npsl -sai
#   -saf -saw -ncs -nsc -sob -nfca -cp33 -ss -ts8 -il1
alias indent='indent -linux -l102 -cbi0 -ut -sc'

# common environment setup (mfukar):
# include and library paths - no other script should set these:
#export LIBRARY_PATH="${HOME}/lib"
#export C_INCLUDE_PATH="${HOME}/include"
export KERNELTAGS=''
export KERNEL_CSCOPE_DB=''

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib/

# Various stuff might be inside $HOME/bin/:
export PATH=${PATH}:${HOME}/bin
# Haskell stuff:
export PATH=${PATH}:~/Library/Haskell/bin
# Add RVM to PATH:
export PATH="$PATH:$HOME/.rvm/bin"

export LESS="-r -X"

# workaround for an iTerm2 bug:
if [ $__os = "Darwin" ]; then
    export LANG='en_US'
fi

# dircolors:
if [ -f /usr/bin/dircolors -a $__os = "Linux" ]; then
    if [ -f ~/.dircolors ]; then
        eval $(dircolors -b ~/.dircolors)
    fi
fi

# map CTRL+Left to backward-word and CTRL+Right to forward-word:
if [[ $- == *i* ]]; then
    bind -f ~/.inputrc
fi

# include an ISO8601 timestamp in the history:
export HISTTIMEFORMAT="%FT%T "

# don't put duplicate lines in the history:
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups

# append to the history file, don't overwrite it:
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS:
shopt -s checkwinsize

# turn extended globs on:
shopt -s extglob

# enable programmable completion features:
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# ..and for OS X:
if hash brew 2>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# terminal & prompt definitions:
PAGER="/bin/sh -c \"unset PAGER;col -bx | \
    $__vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""; export PAGER
BLOCKSIZE=K; export BLOCKSIZE

# Color and other string capability definitions:
if [[ $- == *i* ]]; then
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    BROWN=$(tput sgr0 ; tput setaf 3)
    BLUE=$(tput sgr0 ; tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    LIGHT_GRAY=$(tput setaf 7)
    DARK_GRAY=$(tput bold ; tput setaf 0)
    WHITE=$(tput bold ; tput setaf 7)
    BRIGHT=$(tput bold)
    NO_COLOR=$(tput sgr0)
    REVERSE=$(tput smso)
    UNDERLINE=$(tput smul)
    BLINK=$(tput blink)
fi

# defining this here because it's used in the prompt:
__parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/'
}

# set prompt. Do not use colour codes for 'dumb' terminals (like VIM's):
case $TERM in
    dumb) PS1="\u@\h[\w]<\$(__parse_git_branch)>";;
    *) PS1="\001$RED\002\u\001$NO_COLOR\002 @ \001$BLUE\002\h\001$NO_COLOR\002 [\001$BROWN\002\w\001$NO_COLOR\002]\001$WHITE\002<\001$BLACK\002\$(__parse_git_branch)\001$WHITE\002>\001$NO_COLOR\002";;
esac

case `id -u` in
    0) PS1="${PS1}⚡ ";;
    *) PS1="${PS1}\$ ";;
esac

# java setup:
[ -f $HOME/.bashrc.java ] && . $HOME/.bashrc.java

# python setup:
[ -f $HOME/.bashrc.python ] && . $HOME/.bashrc.python

# keytool functions:
[ -f $HOME/.bashrc.keytool ] && . $HOME/.bashrc.keytool

# screen setup:
[ -f $HOME/.bashrc.screen ] && . $HOME/.bashrc.screen

# OpenSSL helpers setup:
[ -f $HOME/.bashrc.openssl ] && . $HOME/.bashrc.openssl

# BMW-specific stuff:
[ -f $HOME/.bashrc.bmw ] && . $HOME/.bashrc.bmw

# GitHub API token for Homebrew:
[ -f $HOME/.homebrew.token ] && . $HOME/.homebrew.token

# Useful functions:

# Pretty-pring JSON using python's json module and pygments. Doesn't use colors if
# pygmentize doesn't exist:
json()
{
    command -v pygmentize >/dev/null 2>&1 || command -v pygmentize-3.4 >/dev/null 2>&1 || {python -m json.tool}
    python -m json.tool | pygmentize-3.4 -l javascript
}

# compress/uncompress using LZMA:
7zc()
{
    7za a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on archive.7z "$@"
}

7zu()
{
    7za x -o"$@.contents" -- "$@"
}

# jump back multiple directories just by typing multiple dots:
ti()
{
    # If it doesn't contain 3 or more dots, defer to builtin:
    if [ `expr "$1" : '\.\.\.*'` -le 2 ]; then
        cd $1;
        return;
    fi

    local dir=$(pwd)
    local target=${1#.};

    # For each dot other than the first, we go one level up:
    while [ `expr "$target" : '\.\.*'` -ge 1 ];
    do
        target=${target#.};
        dir=${dir}'/..'
    done;
    # Now change directory to the rest of the path:
    cd $dir
}

# perform diff in the current repository/branch between $1-1:$1 :
gdiff()
{
    # Remove any leading dashes or '-r', in case revision numbers are being copied with
    # them from a retarded tool somewhere..
    num=${1##*([-a-zA-Z])}
    rev=${num%%*(\.)}
    git svn log -r"$rev" --stat -p
}

# Alias to remove git submodules:
rm_git_submodule() {
    TMP_FILE=`mktemp /tmp/blob.XXXXXXXXXX`
    sed -e "/$1/d" .gitmodules > $TMP_FILE
    mv $TMP_FILE .gitmodules
    rm -f $TMP_FILE
    git commit .gitmodules -m "Removes $1 from .gitmodules"
    git rm --cached bundle/$1
    git commit -m "Deletes path to submodule $1"
    # Launch git log to review changes before pushing:
    git log -p
}

# set terminal title:
function title {
    echo -ne "\033]0;"$*"\007"
}

# download a URL with cURL, resuming when interrupted:
dlresume() {
    export ec=18; while [ $ec -eq 18 ]; do /usr/bin/curl -O -C - "${1}"; export ec=$?; done
}

