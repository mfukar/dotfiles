# Add this repository's ./bin/ to the PATH:
export PATH="${PATH}:~/dotfiles/bin"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
plugins=(git osx pylint wd)

# Find the OS:
__os=$(uname)

# Workaround for terminator bug:
[[ $(uname) = "Linux" && $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]] && TERM=xterm-256color

# Custom autocompletion functions:
if [[ $__os =~ "Darwin" ]]; then
    fpath=( /usr/local/share/zsh/site-functions "${fpath[@]}" )
fi

# powerlevel9k config & colors. Must be set before sourcing oh-my-zsh.sh:
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_from_right'
POWERLEVEL9K_SHORTEN_DIR_LENGTH='2'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_hostname dir rbenv vcs)
POWERLEVEL9K_CUSTOM_HOSTNAME="hostname"
POWERLEVEL9K_CONTEXT_TEMPLATE="@%m"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='00'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='136'
POWERLEVEL9K_DIR_HOME_BACKGROUND='63'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='63'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='001'
POWERLEVEL9K_DIR_HOME_FOREGROUND='236'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='236'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='254'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='236'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='119'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='214'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='236'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='202'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='236'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='005'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='236'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='245'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='236'


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
    alias l='ls -lAFhG'
elif [[ $__os =~ "Linux" ]]; then
    __vim="vim"
    alias l='ls -lAFhG --color=auto'
else
    __vim="gvim -v"
    alias l='ls -lAFhG --color=auto'
fi

# Environment setup
#
# Homebrew:
export PATH="/usr/local/bin:${PATH}"
# Various stuff might be inside $HOME/bin/:
export PATH=${PATH}:${HOME}/bin
# Haskell stuff:
export PATH=${PATH}:$HOME/Library/Haskell/bin:$HOME/.local/bin
export PATH=${PATH}:$HOME/.stack/programs/x86_64-osx/ghc-8.0.1/bin/
# Add RVM to PATH:
export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Make less attempt to display raw chars:
export LESS="-r -X"

# Set a suitable pager using vim:
PAGER="/bin/sh -c \"unset PAGER;col -bx | \
    $__vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""; export PAGER
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
alias tar="tar --exclude='.git' -"
alias ps='ps -ef'
# clang-format all .c files you come across:
alias clang-format-all='find `pwd` -iname "*.h" -or -iname "*.c" -or -iname "*.cpp" -or -iname "*.hpp" | xargs clang-format -i -style=file'
# Alias for building with CMake out-of-source:
alias cmake-build='rm -rf ./build && mkdir -p build && pushd build && cmake .. && popd'

# Pygmentize systemd units and .ini files:
alias cat-ini='pygmentize -l ini'
alias cat-unit='cat-ini'

# macOS; force restart mDNSResponder
alias dns-flush='sudo killall -HUP mDNSResponder'

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
        pygmentize $jsonfile
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
        pygmentize -l ini $unit
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
    while [ $? -ne 0 ]; do echo "WARNING: Interrupted" ; "$@" ; done
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
    if [ $# -ne 1 ]; then
        return -1
    fi
    local -n array=$1

    while [ ${#array[@]} -gt 1 ]; do
        python ~/Downloads/c2a9806/scripts/bootreport/bootcompare.py -o "${array[0]}" -n "${array[1]}"

        array=(${array[@]:1})
    done
}

# OpenSSL
function openssl_ca() {
    CA=${1:-ca}

    # Create the RSA key:
    openssl genrsa -des3 -out $CA.key 4096

    # Create the CA certificate:
    openssl req -new -x509 -days 3650 -key $CA.key -out $CA.crt -config openssl.cnf

    # Print the certificate in text form:
    openssl x509 -noout -text -in $CA.crt

    # Convert to DER:
    openssl x509 -in $CA.crt -outform der -out $CA.der

    # Convert to PKCS#12:
    openssl pkcs12 -export -out $CA.pfx -inkey $CA.key -in $CA.crt -certfile $CA.crt
}

# Python
[ -f $HOME/.pythonrc ]  && export PYTHONSTARTUP="${HOME}/.pythonrc"
[ -d $HOME/lib/python ] && export PYTHONPATH="${HOME}/lib/python"

# Specifically for use with Voltron. On macOS, it completely breaks everything, so the
# shells can't be used for anything else Python:
prep-voltron() {
    if [[ $__os =~ "Darwin" ]]; then
        [ -d $HOME/Library/Python/2.7/lib/python2.7/site-packages ] && export PYTHONPATH="${HOME}/Library/Python/2.7/lib/python2.7/site-packages"
        [ -d $HOME/Library/Python/2.7/bin ] && export PATH="${PATH}:${HOME}/Library/Python/2.7/bin"
    fi
}

# Directory under $HOME where Python3-specific packages end up, e.g. nosetests:
# Might be breaking things under macOS.
export PATH="${PATH}:${HOME}/Library/Python/3.6/bin/"

# Set up colours for nose. Thankfully non-intrusive:
export NOSE_REDNOSE=1

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

# BMW config
# Depends on the abbreviations file being in ~/Documents/,
# which is fine for me:
bmwspeak() {
    QUOTEFILE="${HOME}/Documents/abbrevs-utf8.csv"

    while getopts ":id" opt; do
        case $opt in
            i)
                CASE_INSENSITIVE='-i'
                ;;
            \?)
                return 1
                ;;
        esac
    done

    # Query terms:
    if [ "$#" -ne 0 ]; then
        set -f
        for term in $*; do
            defs=$(\grep ${CASE_INSENSITIVE} "^${term}" "${QUOTEFILE}")
            SIFS=$IFS; IFS=$'\n'
            for def in $defs; do
                echo -e "BMW abbreviation of the day:\n ${def}" | sed -e 's/;/ - /' | cowsay | lolcat
            done
            IFS=$SIFS
        done
        set +f
        return
    fi

    # Present a random term:
    n=$(wc -l "${QUOTEFILE}" | cut -d' ' -f4)
    c=$(($RANDOM%$n))
    echo -e "BMW abbreviation of the day:\n" $(sed "${c}q;d" "${QUOTEFILE}" | sed -e 's/;/ - /') | cowsay | lolcat
}

sync-date() {
    while [ true ]; do
        ssh $1 "date -s \"@$( date +%s )\"" && echo "Date set.";
        sleep 100;
    done
}

view-boot() {
    if [ "$#" -ne 1 ]; then
        MGU="${MGU:-mgu-lucia}"
    else
        MGU=$1
    fi
    ssh $MGU "systemd-analyze -s 3 --detailed plot > /tmp/boot-plot-${MGU}.svg" && scp $MGU:/tmp/boot-plot-$MGU.svg /tmp && open /tmp/boot-plot-$MGU.svg
}

view-blame() {
    if [ "$#" -ne 1 ]; then
        MGU="${MGU:-mgu-lucia}"
    else
        MGU=$1
    fi

    ssh $MGU "systemd-analyze blame"
}

if [[ $__os =~ "Darwin" ]]; then

    view-deps() {
        if [ "$#" -lt 1 ]; then
            echo "Provide a unit."
            return -1
        fi

        if [ "$#" -lt 2 ]; then
            MGU="${MGU:-mgu-lucia}"
            UNIT=$1
        else
            MGU=$1
            shift
            UNIT="$@"
        fi

        if [ "$#" -gt 1 ]; then
            ssh $MGU "systemd-analyze dot > /tmp/unit-deps.dot ${UNIT}" && scp $MGU:/tmp/unit-deps.dot /tmp/ && cat /tmp/unit-deps.dot | dot -Tsvg > /tmp/unit-deps.svg && open /tmp/unit-deps.svg
        else
            ssh $MGU "systemd-analyze dot > /tmp/${UNIT}-deps.dot ${UNIT}" && scp $MGU:/tmp/$UNIT-deps.dot /tmp && cat /tmp/$UNIT-deps.dot | dot -Tsvg > /tmp/$UNIT-deps.svg && open /tmp/$UNIT-deps.svg
        fi
    }

fi


# Remote-task related stuff, which don't need their own space yet:
#
# Alias force-connecting to a host via SSH:
autoconnect() {
   while [ true ]; do
       ssh -o ConnectTimeout=5 $1
       sleep 5
   done
}

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


# locale-specific stuff is kept out-of-repo:
[ -f "${HOME}"/.localerc ] && . "${HOME}"/.localerc

