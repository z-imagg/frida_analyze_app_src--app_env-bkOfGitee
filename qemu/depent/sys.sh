#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
ArgAptGet="-qq   -y" && \
( set -x && \
apt-get $ArgAptGet update && \
apt-get $ArgAptGet install  build-essential python3-venv python3-pip  ninja-build pkg-config libglib2.0-dev 1>/dev/null && \
##  qemu 5.0.0 、 6.2.0  需要的依赖，  qemu v8.2.2 不需要
apt-get $ArgAptGet install libpixman-1-dev  libpixman-1-0   1>/dev/null && \
apt-get $ArgAptGet install git curl file rsync sudo  1>/dev/null && \
pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple && \
#解决报错: 找不到 ssl/bio.h
gcc --version ;) && \
true