#!/usr/bin/env bash

git config --global --add \
    url."https://${usr}:${psw}@github.com/".insteadOf "https://github.com/"
git config --global --add \
    url."https://${usr}:${psw}@github.com/".insteadOf "git@github.com:"
