#!/usr/bin/bash

#【描述】  下载包 、 解压包 
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#导入配置
source $pdir/docker_instance.sh

declare -r errMsg5="无目录/app/pack，请手工创建并设置主人为当前用户,退出代码5"
[[ -d /app/pack/ ]] || {  echo "$errMsg5" && exit 5 ;}

source /app/bash-simplify/download_unpack_simple.sh

#下载 clang_llvm__15
F="clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4.tar.xz" ; download_unpack_simple https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.0/$F 24927e91021e97fb07d7c95ee1b4bac5  $F /app/pack/ /app/llvm_release_home/
