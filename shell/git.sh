#!/usr/bin/env bash

if [[ ! -z "$(git status --porcelain)" ]]; then
   echo "Generated files changed. Did you run 'tools/dockerfile_assembler.py'?"
   exit 1
fi
