#!/usr/bin/env bash

${#PWD}
echo -e '\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'
bs=$(tput kbs)
echo -e "abcdef${bs}"
printf "abcdef${bs}"
