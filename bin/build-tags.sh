#!/bin/bash

CTAGSBIN=`which ctags`
CSCOPEBIN=`which cscope`

CWD=${1:-`pwd`}
OUT_FNAME='cscope.out'

pushd $CWD &>/dev/null

STARTTIME=$(date +%s)
echo "Generating tag files.."
find -P $(pwd) -type f -a \( -name '*.[ch]' -o -name '*.cpp' -o -name '*.hpp' \) > ./cscope.files
$CSCOPEBIN -buf $OUT_FNAME
rm -f ./cscope.files
echo "Gathering user-defined types.."
$CTAGSBIN --c-kinds=gstu --c++-kinds=gstu -f- $(find . -iname "*.[ch]" -o -iname "*.[ch]pp") | awk 'BEGIN{printf("syntax keyword udType ")} {printf("%s ", $1)} END{print "\nhi def link udType Type"}' > _ud_types.vim
ENDTIME=$(date +%s)

echo "..done in $(($ENDTIME - $STARTTIME)) seconds. :-)"
popd &>/dev/null
