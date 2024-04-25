#!/usr/bin/bash

rm -fr /app/qemu/build-v8.2.2;   
mkdir /app/qemu/build-v8.2.2; 
cd /app/qemu/build-v8.2.2;   
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --enable-tcg && \
make -j4 && \
#make install && \
ln -s /app/qemu/build-v8.2.2 /app/qemu/build-v8.2.2-modify
