#!/bin/bash

CTAGSBIN=`which ctags`
CSCOPEBIN=`which cscope`
__os=$(uname)

if [[ $__os =~ "Darwin" ]]; then
    FIND=$(which gfind)
else
    FIND=$(which find)
fi

CWD=${1:-`pwd`}
OUT_FNAME='cscope.out'

pushd $CWD &>/dev/null

STARTTIME=$(date +%s)
echo "Generating tag files.."
$FIND -P $CWD \
    \( -path "$CWD/Documentation*" -prune \) -o \
    \( -path "$CWD/scripts*" -prune \) -o \
    \( -path "$CWD/drivers*" -prune \) -o \
    \( -path "$CWD/tests*" -prune \) -o \
    \( -path "$CWD/tools*" -prune \) -o \
    \( -iname '*.[ch]' -o -iname '*.[ch]pp' \) -a \
    -type f -fprintf cscope.files '"%p"\n'
# $FIND -P $(pwd) -type f -a \( -name '*.[ch]' -o -name '*.cpp' -o -name '*.hpp' \) -fprintf cscope.files '"%p"\n'
$CSCOPEBIN -bquf $OUT_FNAME
rm -f ./cscope.files
echo "Gathering user-defined types.."
find . \( -path "./Documentation*" -prune \) -o \
       \( -path "./scripts*" -prune \) -o \
       \( -path "./drivers*" -prune \) -o \
       \( -path "./tests*" -prune \) -o \
       \( -iname "*.[ch]" -o -iname "*.[ch]pp" \) -print0 \
 | xargs -0 $CTAGSBIN --c-kinds=gstu --c++-kinds=gstu -f- \
 | sort -uz \
 | awk 'BEGIN{printf("syntax keyword udType ")} {printf("%s ", $1)} END{print "\nhi def link udType Type"}' > _ud_types.vim
ENDTIME=$(date +%s)

echo "..done in $(($ENDTIME - $STARTTIME)) seconds. :-)"
popd &>/dev/null
