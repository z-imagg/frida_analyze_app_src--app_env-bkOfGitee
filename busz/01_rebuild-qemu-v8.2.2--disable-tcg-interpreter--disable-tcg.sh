#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e -u

# 导入配置
#   引入全局变量 比如 gainD_dk
source $pdir/docker_instance.sh

_importBSFn "cpFPathToDir.sh"

buildDir="$prjGRpD/build-v8.2.2"
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
source  /app/cmd-wrap/script/cmd_setup.sh || true
clang_Wrap=/usr/bin/clang
clangXX_Wrap=/usr/bin/clang++

#删除/app/qemu下的各git仓库, configure命令会重新下载这些子仓库
#   因为其中可能有上次clang插件修改的残留物
# /app/qemu/subprojects/dtc
# /app/qemu/subprojects/keycodemapdb
# /app/qemu/subprojects/berkeley-softfloat-3
# /app/qemu/subprojects/berkeley-testfloat-3
#  prjGRpD==/app/qemu
find $prjGRpD  -mindepth 2  -type d -name .git   -print0 | xargs -0 -I@ dirname @ | xargs -I@ rm -fr  @

#编译步骤
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
#     指定编译器使用cmd-wrap包裹的clang
../configure --cc=$clang_Wrap --cxx=$clangXX_Wrap --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --enable-tcg --enable-debug-info && \
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
