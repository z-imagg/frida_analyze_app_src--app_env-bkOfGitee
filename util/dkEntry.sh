#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#本地域名总是要设置的
source $pdir/util/LocalDomainSet.sh
#导入_importBSFn.sh
source $pdir/util/Load__importBSFn.sh

_importBSFn "argCntEqN.sh"

#docker实例初始化
function dkEntry() {


#断言参数个数为3个
echo 3 | argCntEqN $* || return $?

local initProjF=$1
local buszRunF=$2
local manualTxtF=$3

#'true'为true, 其余都为false
#  isDkInitProj == docker实例初始化标记
local _isDkInitProj=false; [[ "X$isDkInitProj" == "Xtrue" ]] && _isDkInitProj=true
#  isDkBuszRun == docker实例运行业务脚本标记
local _isDkBuszRun=false; [[ "X$isDkBuszRun" == "Xtrue" ]] && _isDkBuszRun=true

local flagDone_DkInitProj=/flagDone_DkInitProj
local flagDone_DkBuszRun=/flagDone_DkBuszRun

#此次是否应该执行$initProjF:     从未执行$initProjF           且    调用者要求执行$initProjF
local do_initProjF=false; ( [[ ! -f $flagDone_DkInitProj ]] &&  $_isDkInitProj ;) && do_initProjF=true
#此次是否应该执行$buszRunF:     从未执行$buszRunF             且    调用者要求执行$buszRunF
local do_buszRunF=false;  ( [[ ! -f $flagDone_DkBuszRun  ]] &&  $_isDkBuszRun  ;) && do_buszRunF=true

#若此次应该执行$initProjF或$buszRunF, 则应source此两脚本
( $do_initProjF ||  $do_buszRunF ;) && { \
#本地域名总是要设置的
source $pdir/util/LocalDomainSet.sh ; \
#导入_importBSFn.sh
source /app/bash-simplify/_importBSFn.sh ;}

# 若docker实例初次运行时，则 进行初始化
( \
#若此次应该执行$initProjF 则执行之       并 设置标记表示 已执行$initProjF
{ $do_initProjF && bash -x $initProjF && touch $flagDone_DkInitProj ;} ; \
#若此次应该执行$buszRunF  则执行之       并 设置标记表示 已执行$buszRunF
{ $do_buszRunF  &&  bash -x $buszRunF && touch $flagDone_DkBuszRun ;} ; \
true ;) && \
# 显示 使用手册文本
bash $manualTxtF && \
# 最后启动bash
bash

}

# 使用举例
# dkEntry "$pdir/qemu/init_proj.sh"