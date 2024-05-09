#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#导入配置
source $pdir/docker_instance.sh
#
source $pdir/util/run_shLs_in_dir.sh

_importBSFn "argCntEqN.sh"

#docker实例初始化
function dkEntry() {

local InitProjF="$pdir/init_proj.sh"
local BuszShD="$pdir/busz/"
local manualTxtF="$pdir/manual_txt.sh"

#'true'为true, 其余都为false
#  isDkInitProj == docker实例初始化标记
local _isDkInitProj=false; [[ "X$isDkInitProj" == "Xtrue" ]] && _isDkInitProj=true
#  isDkBuszRun == docker实例运行业务脚本标记
local _isDkBuszRun=false; [[ "X$isDkBuszRun" == "Xtrue" ]] && _isDkBuszRun=true

local flagDone_InitProj=/tmp/flagDone_InitProj_${envNm}
local flagDone_DkBuszRun=/tmp/flagDone_DkBuszRun_${envNm}

#此次是否应该执行$InitProjF:     从未执行$InitProjF           且    调用者要求执行$InitProjF
local do_InitProjF=false; ( [[ ! -f $flagDone_InitProj ]] &&  $_isDkInitProj ;) && do_InitProjF=true
#此次是否应该执行$BuszShD:     从未执行$BuszShD             且    调用者要求执行$BuszShD
local do_BuszRunF=false;  ( [[ ! -f $flagDone_DkBuszRun  ]] &&  $_isDkBuszRun  ;) && do_BuszRunF=true

#若此次应该执行$InitProjF或$BuszShD, 则应source此两脚本
( $do_InitProjF ||  $do_BuszRunF ;) && { \
#导入配置
source $pdir/docker_instance.sh   ;}

# 若docker实例初次运行时，则 进行初始化
( \
#若此次应该执行$InitProjF 则执行之       并 设置标记表示 已执行$InitProjF
{ $do_InitProjF && pdir="$pdir" bsFlg="$bsFlg"  bash $bsFlg $InitProjF && touch $flagDone_InitProj && echo "已执行InitProjF:$InitProjF" ;} ; \
#若此次应该执行$BuszShD  则执行之       并 设置标记表示 已执行$BuszShD
{ $do_BuszRunF  &&  run_shLs_in_dir $BuszShD  &&  touch $flagDone_DkBuszRun && echo "已执行BuszShD:$BuszShD" ;} ; \
true ;) && \
# 显示 使用手册文本
bash $manualTxtF && \
# 最后  启动bash（以bashrc.sh为init-file）
{ bash --init-file $pdir/bashrc.sh ;}

}

dkEntry #实际执行依次了此三脚本: "$pdir/init_proj.sh" "$pdir/busz_run.sh" "$pdir/manual_txt.sh"
