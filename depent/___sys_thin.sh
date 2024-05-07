#!/usr/bin/bash

#【描述】  qemu v8.2.2 运行时依赖,  编译产物qemu-system-x86_x64运行需要的依赖
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#运行时依赖
ArgAptGet="-qq   -y" && \
(   \
##     qemu v8.2.2 运行时依赖
sudo apt-get $ArgAptGet install libpixman-1-dev  libpixman-1-0     1>/dev/null && \
sudo apt-get $ArgAptGet install  libglib2.0-dev  1>/dev/null && \
true ;) && \
true