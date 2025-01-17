#!/bin/bash

#【描述】  按顺序运行给定目录下的直接*.sh脚本们
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u
#导入配置
source $pdir/docker_instance.sh
_importBSFn "argCntEq1.sh"

# 按顺序运行给定目录下的直接*.sh脚本们
function run_shLs_in_dir() {

#  若函数参数不为1个 ， 则返回错误
argCntEq1 $* || return 81

local _dir=$1

#业务脚本们路径 读取到 BASH变量shFPath_Arr中
#  跳过 以 ___ 开头的文件,  比如 depent/___sys.sh
mapfile -t shFPath_Arr < <(find $_dir/  -maxdepth 1  -and  -type f -and -name "*.sh" \( -not -name "___*" \) | sort --unique )

#若busz目录下无脚本文件,则正常退出
[[ ! -v shFPath_Arr || ${#shFPath_Arr} -eq 0 ]] && exit 0

echo "脚本路径数组:【${shFPath_Arr[@]}】"

#循环执行脚本
for shFPathK in "${shFPath_Arr[@]}"; do
    # 注意bash前给定的参数们
    pdir="$pdir" bsFlg="$bsFlg"  bash $bsFlg  "$shFPathK"
done


}

# #用法举例:
# source $pdir/util/run_shLs_in_dir.sh
# run_shLs_in_dir $pdir/busz



