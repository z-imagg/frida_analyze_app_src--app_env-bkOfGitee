#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#安装 编译命令拦截器
source  /app/cmd-wrap/script/cmd_setup.sh

#编译步骤
buildDir="/app/qemu/build-v5.0.0" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --disable-tcg && \ 
make -j4
# make install


#卸载 编译命令拦截器
bash /app/cmd-wrap/script/remove_interceptor.sh


#*-linux-user : 用户态模拟，  系统调用转发给物理宿主机操作系统. 因此不支持执行内核
#*-softmmu    ：全系统模拟 

#--disable-tcg  禁用tcg的话，是不能有目标 i386-linux-user ，否则 报错：
#ERROR: TCG disabled, but hardware accelerator not available for 'i386-linux-user'
