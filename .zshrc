# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add this repository's ./bin/ to the PATH:
export PATH="${PATH}:${HOME}/dotfiles/bin"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=24

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
plugins=(git fzf wd)

# Find the OS:
__os=$(uname)

# Set TERMINFO temporarily:
export TERMINFO=/usr/share/terminfo

# Custom autocompletion functions:
if [[ $__os =~ "Darwin" ]]; then
    fpath=( /usr/local/share/zsh/site-functions "${fpath[@]}" )
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# override the default umask:
umask 077

# nuke shared history:
unsetopt share_history

# iTerm2's shell integration:
#if [[ $__os =~ "Darwin" ]]; then
#    source ~/.iterm2_shell_integration.`basename $SHELL`
#fi

# Set aliases overriding those provided by oh-my-zsh.
if [[ $__os =~ "Darwin" ]]; then
    __vim="mvim -v"
    alias l='ls -lAFhGn'
elif [[ $__os =~ "Linux" ]]; then
    __vim="vim"
    alias l='ls -lAFhGn --color=auto'
else
    __vim="gvim -v"
    alias l='ls -lAFhGn --color=auto'
fi

# Environment setup
#
# zsh - no extended globbing
unsetopt extendedglob
# Homebrew:
export PATH="${PATH}:/usr/local/bin"
# Various stuff might be inside $HOME/bin/:
export PATH=${PATH}:${HOME}/bin
# Haskell stuff:
export PATH=${PATH}:$HOME/Library/Haskell/bin:$HOME/.local/bin
export PATH=${PATH}:$HOME/.stack/programs/x86_64-osx/ghc-8.0.1/bin/

# Make less attempt to display raw chars:
export LESS="-r -X"

# Set a default blocksize for GNU programs (ls, df, du):
BLOCKSIZE=K; export BLOCKSIZE

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Fuck zsh messing with other program's output:
export PROMPT_EOL_MARK=''

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR=$__vim
fi

alias vim=$__vim
alias peek='less -nU'
alias hexdump='hexdump -C'
alias golf='ruby ${HOME}/lib/golfscript.rb'
alias rm='rm -i'
alias grep="grep -n --color=auto --exclude-dir='.hg' --exclude-dir=\"target.*\""
alias egrep='grep -E'
alias ps='ps -ef'
alias rsync='rsync -azhx --stats'
# clang-format all .c files you come across:
alias clang-format-all='find `pwd` -iname "*.h" -or -iname "*.c" -or -iname "*.cpp" -or -iname "*.hpp" | xargs clang-format -i -style=file'
# Gather user-defined types with ctags, for highlighting with vim:
alias build-tags='build-tags.sh'
# macOS; force restart mDNSResponder
alias dns-flush='sudo killall -HUP mDNSResponder'
# pushd/popd aliases:
alias pu='pushd'
alias po='popd'

### Colours
#
# ls colors:
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"

# Pretty-printers
#
# Colors from GCC messages?
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# JSON:
cat_json() {
    for jsonfile in "$@"; do
        echo "$(tput bold)$jsonfile$(tput sgr0)"
        pygmentize -O style=native $jsonfile
    done
}

# For patches:
cat_patch() {
    for patch in "$@"; do
        echo "$(tput bold)$patch$(tput sgr0)"
        pygmentize $patch
    done
}

# For systemd units and ini files:
cat_ini() {
    for unit in "$@"; do
        echo "$(tput bold)$unit$(tput sgr0)"
        pygmentize -O style=native -l ini $unit
    done
}
alias cat-json='cat_json'
alias cat-patch='cat_patch'
alias cat-ini='cat_ini'
alias cat-unit='cat_ini'

# Useful functions
#
# retry a command or function until a zero exit code:
retry() {
    while : ; do
        "$@"
        [ $? -eq 0 ] && break
        echo "WARNING: Command failed, return code $?"
    done
}

# compress/uncompress using LZMA:
7zc()
{
    7za a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -v40m archive.7z "$@"
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
gdiff() {
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

# download a URL with cURL, resuming when interrupted:
dlresume() {
    /usr/bin/curl -O -C - "${1}"
    while [ $? -ne 0 ]; do
        /usr/bin/curl -O -C - "${1}"
    done
}

# Perform a command in successive pairs of array elements:
cmp-pairwise() {
    if [ $# -ne 2 ]; then
        echo 'Usage: cmp-pairwise <cmd> <array>'
        return -1
    fi
    local -n cmd=$1
    local -n array=$2

    while [ ${#array[@]} -gt 1 ]; do
         "${cmd}" -o "${array[0]}" -n "${array[1]}"

        array=(${array[@]:1})
    done
}

# Python
[ -f $HOME/.pythonrc ]  && export PYTHONSTARTUP="${HOME}/.pythonrc"
[ -d $HOME/lib/python ] && export PYTHONPATH="${HOME}/lib/python"

# Directory under $HOME where Python3-specific packages end up, e.g. nosetests:
# Might be breaking things under macOS.
export PATH="${PATH}:${HOME}/Library/Python/3.11/bin/"


# Build a single file with clang, taking the build command from an existing `compile_commands.json`:
clang-build-me() {
    python3  -c 'import json; fh = open("compile_commands.json"); j=json.loads(fh.read()); argv= [i["arguments"] for i in j if "interprocess" in i["file"]][0]; print(" ".join(argv))'
}

# Screen & tmux

# Remind me of screen sessions:
if [ -d /var/run/screen/S-$USER/ ]; then
    n=$(find /var/run/screen/S-$USER/ -type p | wc -l)
    if [ $n -gt 0 ]; then
        test x"$TERM" = xscreen && test -n "$WINDOW" \
            && echo "You have $n active screen sessions (and this is one of them)." \
            || echo "You have $n active screen sessions."
    fi
fi

# Remind me of tmux sessions:
if [ -x /usr/bin/tmux ]; then
    n=$(tmux list-sessions 2>/dev/null|wc -l)
    if [ $n -gt 0 ]; then
        test x"$TERM" = xscreen && test -n "$TMUX" \
            && echo "You have $n active tmux sessions (and this is one of them)." \
            || echo "You have $n active tmux sessions."
    fi
fi

# Local and/or secret defs:
[ -f $HOME/.zshrc.local ] && . $HOME/.zshrc.local


# Experimental

# fshow - git commit browser (enter for show, ctrl-d for diff) using fzf
fshow() {
  local out shas sha q k
  while out=$(git log --graph --color=always \
              --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
              fzf --ansi --multi --no-sort --reverse --query="$q" \
              --print-query --expect=ctrl-d); do
      q=$(head -1 <<< "$out")
      k=$(head -2 <<< "$out" | tail -1)
      shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
      [ -z "$shas" ] && continue

      if [ "$k" = ctrl-d ]; then
          git diff --color=always $shas | less -R
      else
          for sha in $shas; do
              git show --color=always $sha | less -R
          done
      fi
  done
}

# Start a CMake out-of-tree build with supplied arguments
cbuild() {
    cmake -S . -B build -D CMAKE_BUILD_TYPE=Debug "$@"
    cmake --build build
}

# locale-specific stuff is kept out-of-repo:
[ -f "${HOME}"/.localerc ] && . "${HOME}"/.localerc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# powerlevel10k: run `p10k configure` or edit ~/.p10k.zsh to further customise.
if [ -z "${ZED_TERM}" ]
then
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
    [[ ! -f ~/.p10k-simple.zsh ]] || source ~/.p10k-simple.zsh
fi
