#!/usr/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

msg_tip="""
无预设配置文件.config , 
需以nconfig手工选填配置文件以生成配置文件/app/linux/.config ,参考此文注释部分: http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/linux_x86_64__build.sh
按回车继续:
"""

dfltCfgF="/fridaAnlzAp/app_qemu/app_bld/linux5/.config.default"
myCfgF="/fridaAnlzAp/app_qemu/app_bld/linux5/.config.pvh__debug"
objCfgF="/app/linux/.config"
#是否有预设配置文件 .config.pvh__debug
HasMyCfg=false; [[ -f $myCfgF ]] && HasMyCfg=true
#【取反】NoMyCfg==not HasMyCfg
NoMyCfg=true; $HasMyCfg && NoMyCfg=false

cd /app/linux/ && \
make mrproper && \
make clean && \
#首次 nconfig手工配置 并保存为 预设配置文件 ， 下次 无需nconfig 而 直接使用该 预设配置文件
# 【下次】若有预设配置文件 , 则使用之
{ $HasMyCfg && cp -v $myCfgF   $objCfgF ; \
# 【首次】若无预设配置文件 , 则以nconfig手工选填配置文件 并 保存之供给下次用（下次无需手工nconfig）
$NoMyCfg  && read -p "$msg_tip" &&  ( make ARCH=x86_64 CC=gcc defconfig && cp -v $objCfgF $dfltCfgF && make ARCH=x86_64 CC=gcc nconfig && cp -v $objCfgF $myCfgF ;) ; \
true ;} && \
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