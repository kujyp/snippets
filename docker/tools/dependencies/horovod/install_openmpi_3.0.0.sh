#!/bin/bash -xe


(
cd /tmp
wget https://download.open-mpi.org/release/open-mpi/v3.0/openmpi-3.0.0.tar.gz
gunzip -c openmpi-3.0.0.tar.gz | tar xf -

(
cd openmpi-3.0.0
./configure --prefix=/usr/local --with-cuda
make -j $(nproc) all
make install
ldconfig
)

rm -rf openmpi-3.0.0
rm -f openmpi-3.0.0.tar.gz
)
