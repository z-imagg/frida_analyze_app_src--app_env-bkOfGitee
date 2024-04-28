#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#本地域名总是要设置的
source /fridaAnlzAp/app_qemu/app_bld/util/LocalDomainSet.sh
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq1.sh)

#docker实例初始化
function dkInstInit() {


#断言参数个数为1个
argCntEq1 $* || return $?

local initProjF=$1

# 若docker实例初次运行时，则 进行初始化
$isDkInstInit && bash -x $initProjF && \
# 进入bash  #调用.bashrc
/bin/bash --rcfile /root/.bashrc

}

# 使用举例
# dkInstInit "/fridaAnlzAp/app_qemu/app_bld/qemu/init_proj.sh"