#!/bin/bash

(crontab -l; echo "0 * * * * ~/workspace/documents/dotfiles/scripts/crontab_hourly.sh") | crontab -

crontab -l | grep -v "~/workspace/documents/dotfiles/crontab_hourly.sh" | crontab -
crontab -l
