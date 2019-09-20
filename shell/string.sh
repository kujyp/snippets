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

echo ${email%%@example.com}
