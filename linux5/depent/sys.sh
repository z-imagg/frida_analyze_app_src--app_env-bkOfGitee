#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
ArgAptGet="-qq   -y" && \
# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
( set -x && \
apt-get $ArgAptGet update && \
apt-get $ArgAptGet install  build-essential 1>/dev/null && \
#libncurses5-dev被menuconfig需要
apt-get $ArgAptGet install libncurses5-dev 1>/dev/null && \
#解决报错: 找不到 flex、找不到 bison
#  flex bison 被linux-5.0需要,  但linux-4.14-y不需要
apt-get $ArgAptGet install flex bison 1>/dev/null && \
#解决报错: 找不到 ssl/bio.h
apt-get $ArgAptGet install libssl-dev 1>/dev/null && \
#解决报错: 找不到bc
apt-get $ArgAptGet install bc 1>/dev/null && \
##解决报错
apt-get $ArgAptGet install libelf-dev  1>/dev/null && \
#工具
apt-get $ArgAptGet install git file cpio wget curl rsync sudo 1>/dev/null && \
# gcc (Ubuntu 5.4.0-6ubuntu1~22.04.12) 5.4.0 20160609
gcc --version ;) && \
true