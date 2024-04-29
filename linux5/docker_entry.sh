#!/bin/bash +x

#ubuntu22.04 bash路径为 /bin/bash,  当错写为 '#!/usr/bin/bash' 会导致报错信息不友好 :
#   exec /fridaAnlzAp/app_qemu/app_bld/linux5/docker_entry.sh: no such file or directory
#      不是没有 docker_entry.sh ,  而是 docker_entry.sh 中写的 解释器 '#!/usr/bin/bash' 不存在


#【描述】  
#【依赖】   
#【术语】 
#【备注】   


#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

source /fridaAnlzAp/app_qemu/app_bld/util/dkEntry.sh

declare -r PrjHm="/fridaAnlzAp/app_qemu/app_bld/linux5"

#docker实例初始化
dkEntry "$PrjHm/init_proj.sh" "$PrjHm/busz_run.sh" "$PrjHm/manual_txt.sh"

