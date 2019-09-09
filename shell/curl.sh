#!/usr/bin/env bash

# Curl upload progress
https://stackoverflow.com/questions/9973056/curl-how-to-display-progress-information-while-uploading
curl -X POST -o upload.txt -F file=@truncate_100g http://10.113.164.75/static/1
