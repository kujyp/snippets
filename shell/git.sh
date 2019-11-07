#!/usr/bin/env bash

if [[ ! -z "$(git status --porcelain)" ]]; then
   echo "Generated files changed. Did you run 'tools/dockerfile_assembler.py'?"
   exit 1
fi


git tag -a "spocube_v1.7.5" -m "[스포큐브] v1.7.5"
git push origin spocube_v1.7.5


## How to use git diff to patch file
# query: git diff patch
# Ref: https://gist.github.com/zeuxisoo/980174#gistcomment-2660495
# 주의1: git root 경로에서 patch -p1 해야 재대로 파일 찾아감
# (cd ../..; patch -p1 < ../patch_beforeadding.diff)
# 주의2: git add 제거하고서 git diff 뽑아야 재대로된 결과 나옴.(deleted 는 또 안나오네..)
git diff > patch.diff
patch -p1 < patch.diff
