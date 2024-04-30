#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#本地域名总是要设置的
source /fridaAnlzAp/app_qemu/dk_util/LocalDomainSet.sh
#导入_importBSFn.sh
source /fridaAnlzAp/app_qemu/dk_util/Load__importBSFn.sh

_importBSFn "argCntEqN.sh"

#docker实例初始化
function dkEntry() {


#断言参数个数为3个
echo 3 | argCntEqN $* || return $?

local initProjF=$1
local buszRunF=$2
local manualTxtF=$3

#'true'为true, 其余都为false
#  isDkInstInit == docker实例初始化标记
local _isDkInstInit=false; [[ "X$isDkInstInit" == "Xtrue" ]] && _isDkInstInit=true
#  isDkBuszRun == docker实例运行业务脚本标记
local _isDkBuszRun=false; [[ "X$isDkBuszRun" == "Xtrue" ]] && _isDkBuszRun=true

# 若docker实例初次运行时，则 进行初始化
{ $_isDkInstInit && bash -x $initProjF ;} && \
# 若运行业务脚本，则 运行之
{ $_isDkBuszRun &&  bash -x $buszRunF ;} && \
# 显示 使用手册文本
bash $manualTxtF && \
# 最后启动bash
bash

}

# 使用举例
# dkEntry "/fridaAnlzAp/app_qemu/app_bld/qemu/init_proj.sh"