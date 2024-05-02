#!/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#本地域名总是要设置的
source $pdir/util/LocalDomainSet.sh
#导入_importBSFn.sh
source $pdir/util/Load__importBSFn.sh


_importBSFn "cpFPathToDir.sh"
# 引入全局变量 gainD_dk
source $pdir/util/dkVolMap_gain_def.sh


outF1=/app/linux/vmlinux
outF2=/app/linux/arch/x86/boot/bzImage

#编译产物展示 函数
function printLinuxKernel() {
echo "展示linux内核编译产物"
ls -lh  $outF1
# -rwxr-xr-x   22M  vmlinux
file   $outF1
# vmlinux: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=6c22a4b562ebb84c9d1055bb9e341363d4844eab, not stripped
ls -lh $outF2
# -rw-r--r--   7.5M   arch/x86/boot/bzImage
file $outF2
}

#如果已有编译产物，则显示产物 并 正常退出(退出代码0)
[[ -f $outF1 ]] && [[ -f $outF2 ]] && printLinuxKernel && exit 0

#调用nconfig手工配置获得.config， 或者用现成的.config
function getConfig() {
local msg_tip="""
无预设配置文件.config , 
需以nconfig手工选填配置文件以生成配置文件/app/linux/.config ,参考此文注释部分: http://giteaz:3000/frida_analyze_app_src/app_env/src/branch/app/qemu/linux5/busz/linux_x86_64__build.sh
按回车继续:
"""

local dfltCfgF="$pdir/.config.default"
local myCfgF="$pdir/.config.pvh__debug"
local objCfgF="/app/linux/.config"
#是否有预设配置文件 .config.pvh__debug
local HasMyCfg=false; [[ -f $myCfgF ]] && HasMyCfg=true
#【取反】NoMyCfg==not HasMyCfg
local NoMyCfg=true; $HasMyCfg && NoMyCfg=false

#首次 nconfig手工配置 并保存为 预设配置文件 ， 下次 无需nconfig 而 直接使用该 预设配置文件
# 【下次】若有预设配置文件 , 则使用之
{ $HasMyCfg && cp -v $myCfgF   $objCfgF ; \
# 【首次】若无预设配置文件 , 则以nconfig手工选填配置文件 并 保存之供给下次用（下次无需手工nconfig）
$NoMyCfg  && read -p "$msg_tip" &&  ( make ARCH=x86_64 CC=gcc defconfig && cp -v $objCfgF $dfltCfgF && make ARCH=x86_64 CC=gcc nconfig && cp -v $objCfgF $myCfgF ;) ; \
true ;}

}

#编译步骤
cd /app/linux/ && \
make mrproper && \
make clean && \
getConfig && \
make ARCH=x86_64 CC=gcc -j 6  V=1 && \
# 收集产物
cpFPathToDir  $outF1 $gainD_dk/ && \
cpFPathToDir  $outF2 $gainD_dk/ && \



#编译产物展示
printLinuxKernel

#####以下是文档

#nconfig 和 menuconfig 都是 文本界面, 但 nconfig更好操作一些

#defconfig==default config==默认配置
#若去掉 nconfig 不会弹出修改配置菜单 


#linux-5.0 的 nconfig 启用PVH、试图启用调试: 
# 启用PVH:
#   Processor type and features --> Linux guest support  --> Support for running PVH guests
# 试图启用调试
#   General  --> Include all symbols in kallsyms
#   kernel hacking --> Compile-time checks and compiler options --> Compile the kernel with debug info
#   kernel hacking --> Kernel debugging (默认已启用)

#nconfig 生成的配置保存在文件.config中,  mrproper && clean 会删除 .config文件
