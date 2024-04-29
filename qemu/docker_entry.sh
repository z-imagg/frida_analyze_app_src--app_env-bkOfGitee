#!/bin/bash -x

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

source /fridaAnlzAp/app_qemu/app_bld/util/dkEntry.sh

#docker实例初始化
dkEntry "/fridaAnlzAp/app_qemu/app_bld/qemu/init_proj.sh"
