#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/cpFPathToDir.sh)
# 引入全局变量 gainD_dk
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_gain.sh


buildDir="/app/qemu/build-v5.0.0"
outF1="$buildDir/i386-softmmu/qemu-system-i386"
outF2="$buildDir/x86_64-softmmu/qemu-system-x86_64"

#展示编译产物 函数
function printOutF() {
ls -lh $outF1 && file $outF1
ls -lh $outF2 && file $outF2
}

#如果已有编译产物，则显示产物 并 正常退出(退出代码0)
[[ -f $outF1 ]] && [[ -f $outF2 ]] && printOutF && exit 0

#安装 编译命令拦截器
source  /app/cmd-wrap/script/cmd_setup.sh

#编译步骤
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --disable-tcg && \ 
make -j4
# make install
# 收集产物
cpFPathToDir  $outF1 $gainD_dk/ && \
cpFPathToDir  $outF2 $gainD_dk/ && \
#展示编译产物
printOutF

#卸载 编译命令拦截器
bash /app/cmd-wrap/script/remove_interceptor.sh


#*-linux-user : 用户态模拟，  系统调用转发给物理宿主机操作系统. 因此不支持执行内核
#*-softmmu    ：全系统模拟 

#--disable-tcg  禁用tcg的话，是不能有目标 i386-linux-user ，否则 报错：
#ERROR: TCG disabled, but hardware accelerator not available for 'i386-linux-user'


##编译产物记录
# + ls -lh /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386
# -rwxr-xr-x  46M 2024年4月28日 /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386
# + file /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386
# /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=826f8b9fd3f750bab31aea2a750eee1a25c65d97, for GNU/Linux 3.2.0, with debug_info, not stripped
# + ls -lh /app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64
# -rwxr-xr-x  46M 2024年4月28日 /app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64
# + file /app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64
# /app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=190dddb2a607efc3424e64f511c2df9e681afa13, for GNU/Linux 3.2.0, with debug_info, not stripped
