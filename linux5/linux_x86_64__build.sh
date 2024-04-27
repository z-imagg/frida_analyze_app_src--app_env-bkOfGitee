#!/usr/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

cd /app/linux/ && \
make mrproper && \
make clean && \
make ARCH=x86_64 CC=gcc defconfig && \
make ARCH=x86_64 CC=gcc nconfig && \
make ARCH=x86_64 CC=gcc -j 6  V=1

ls -lh  vmlinux
# -rwxr-xr-x   22M  vmlinux

file   vmlinux
# vmlinux: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=6c22a4b562ebb84c9d1055bb9e341363d4844eab, not stripped

ls -lh arch/x86/boot/bzImage 
# -rw-r--r--   7.5M   arch/x86/boot/bzImage

file arch/x86/boot/bzImage 

#####以下是文档

#nconfig 和 menuconfig 都是 文本界面, 但 nconfig更好操作一些

#defconfig==default config==默认配置
#若去掉 nconfig 不会弹出修改配置菜单 


#linux-5.0 的 nconfig 启用PVH、试图启用调试: 
# 启用PVH:
#   Processor type and features --> Linux guest support  --> Support for running PVH guests
# 试图启用调试
#   kernel hacking --> Compile-time checks and compiler options --> Compile the kernel with debug info
#   kernel hacking --> Kernel debugging (默认已启用)
#   General  --> Include all symbols in kallsyms

#nconfig 生成的配置保存在文件.config中,  mrproper && clean 会删除 .config文件