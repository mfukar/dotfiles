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
$FIND -P $(pwd) -type f -a \( -name '*.[ch]' -o -name '*.cpp' -o -name '*.hpp' \) -fprintf cscope.files '"%p"\n'
$CSCOPEBIN -buf $OUT_FNAME
rm -f ./cscope.files
echo "Gathering user-defined types.."
find . \( -iname "*.[ch]" -o -iname "*.[ch]pp" \) -print0 | xargs -0 $CTAGSBIN --c-kinds=gstu --c++-kinds=gstu -f- | awk 'BEGIN{printf("syntax keyword udType ")} {printf("%s ", $1)} END{print "\nhi def link udType Type"}' > _ud_types.vim
ENDTIME=$(date +%s)

echo "..done in $(($ENDTIME - $STARTTIME)) seconds. :-)"
popd &>/dev/null
