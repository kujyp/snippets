#!/usr/bin/env bash

tar_filename=results_${MTML_RESOURCE_NAME}.tar
tar cvf ${tar_filename} *


cd /Users/jaeyoung/google_drive/영구공유/공인인증서
if [[ ! -f yessign.tar ]]; then
    tar cvf yessign.tar yessign
fi

mkdir -p ~/library/Preferences/NPKI
cp yessign.tar ~/library/Preferences/NPKI/

cd ~/library/Preferences/NPKI/
if [[ -d yessign ]]; then
  echo "Delete yessign..."
  rm -rf yessign
fi

tar xf yessign.tar
rm -f yessign.tar
```
- parallels
```bash
cd /Users/jaeyoung/google_drive/영구공유/공인인증서
if [[ ! -f yessign.tar ]]; then
    tar cvf yessign.tar yessign
fi

cd /Volumes/\[C\]\ Windows\ 10/Users/jaeyoung/AppData/LocalLow
mkdir -p NPKI
cd NPKI
if [[ -d yessign ]]; then
  echo "Delete yessign..."
  rm -rf yessign
fi

cp /Users/jaeyoung/google_drive/영구공유/공인인증서/yessign.tar ./
tar xf yessign.tar
rm -f yessign.tar
