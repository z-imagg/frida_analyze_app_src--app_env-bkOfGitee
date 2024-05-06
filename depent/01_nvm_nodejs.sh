#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  nvm_.sh 加下划线是为了防止和nvm重复

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

mkdir -p /app/nvm && \
#nvm克隆. TODO 有隐患， 应改为 在下一行写 切换到 远程标签v0.39.7 ，但我始终不知道怎么写这句命令。
#  https://github.com/nvm-sh/nvm.git  ,  https://gitee.com/repok/nvm-sh--nvm.git
{ [[ -f /app/nvm/.git/config ]] ||  git clone --branch=v0.39.5  https://gitclone.com/github.com/nvm-sh/nvm.git /app/nvm ;} && \
#nvm函数导入
source /app/nvm/nvm.sh 1>/dev/null 2>/dev/null && \
#nvm安装nodejs-v18.19.1 ;  v18.19.1 是 nodejs  LTS v18 系列 中 最后一个版本
export NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/ && \
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/ && \
# NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist nvm  ls-remote | grep v18. | grep LTS
NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist nvm install v18.19.1  1>/dev/null 2>/dev/null && \
true