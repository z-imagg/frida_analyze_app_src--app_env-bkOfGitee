#!/bin/bash -x

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

source /fridaAnlzAp/prj_env/util/dkEntry.sh

declare -r PrjHm="/fridaAnlzAp/app_qemu/app_bld/qemu"

#docker实例初始化
dkEntry "$PrjHm/init_proj.sh" "$PrjHm/busz_run.sh" "$PrjHm/manual_txt.sh"

