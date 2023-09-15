#!/usr/bin/env bash

tar_filename=results_${MTML_RESOURCE_NAME}.tar
tar cvf ${tar_filename} *


cd /Users/jaeyoung/Library/CloudStorage/GoogleDrive-pjo901018@gmail.com/My\ Drive/영구공유/공인인증서
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


tar zcvf openmpi-3.0.0-linux.tar.gz openmpi
tar xf openmpi-3.0.0.tar.gz -C /usr/local
tar --no-same-owner -xzf cudnn-10.0-linux-x64-v7.3.1.20.tgz -C /usr/local --wildcards {cuda/lib64/libcudnn.so*,cuda/include/*} \