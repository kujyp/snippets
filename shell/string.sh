#!/usr/bin/env bash

## string length
${#PWD}

## Trim leading
answer=n123N
echo ${answer#[nN]}
# > 123N

## Trim trailing
answer=n123N
echo ${answer%[nN]}
# > n123

### Trim question
q=n123N?
echo ${q%?}
# > n123N

q=n123N?1
echo ${q%?}
# > n123N?

q=n123N?1
echo ${q%\?}
# > n123N?1

q=n123N?
echo ${q%\?}
# > n123N



echo ${email%%@example.com}


answer=y
test -z "${answer#[yYnN]}" && echo true
# > true

answer=Y
test -z "${answer#[yYnN]}" && echo true
# > true

answer=n
test -z "${answer#[yYnN]}" && echo true
# > true

answer=N
test -z "${answer#[yYnN]}" && echo true
# > true
answer=No
test -z "${answer#[yYnN]}" && echo true
# > ""



## Remove white space
awk '{$1=$1};1'
