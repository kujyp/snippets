#!/usr/bin/env bash

if [[ ! -z "$(git status --porcelain)" ]]; then
   echo "Generated files changed. Did you run 'tools/dockerfile_assembler.py'?"
   exit 1
fi


git tag -a "spocube_v1.7.5" -m "[스포큐브] v1.7.5"
git push origin spocube_v1.7.5
