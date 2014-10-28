#!/bin/bash

CTAGSBIN=`which ctags`
CSCOPEBIN=`which cscope`

CWD=${1:-`pwd`}
OUT_FNAME='cscope.out'

pushd $CWD

echo -n "Generating tag files.."
find -P $(pwd) -type f -a \( -name '*.[ch]' -o -name '*.cpp' \) > ./cscope.files
$CSCOPEBIN -buf $OUT_FNAME
rm -f ./cscope.files

echo "done. :-)"
popd
