#!/usr/bin/env bash

# "snippets/shell/space_arg_test.sh"
# "snippets/shell/space_arg_test.sh 0"
# "snippets/shell/space_arg_test.sh 0 "
# "snippets/shell/space_arg_test.sh 0  "
# "snippets/shell/space_arg_test.sh 0 '' "
# "snippets/shell/space_arg_test.sh 0 ' '"
# 'snippets/shell/space_arg_test.sh 0 "" '
unset a
unset b
unset c
a=$1
b=$2
c=$3

if [[ -z $a ]]
then
  echo "-z \$a is true"
else
  echo "-z \$a is false"
fi
if [[ -z $b ]]
then
  echo "-z \$b is true"
else
  echo "-z \$b is false"
fi
if [[ -z $c ]]
then
  echo "-z \$c is true"
else
  echo "-z \$c is false"
fi
echo ""

if [[ -n $a ]]
then
  echo "-n \$a is true"
else
  echo "-n \$a is false"
fi
if [[ -n $b ]]
then
  echo "-n \$b is true"
else
  echo "-n \$b is false"
fi
if [[ -n $c ]]
then
  echo "-n \$c is true"
else
  echo "-n \$c is false"
fi