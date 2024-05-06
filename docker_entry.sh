#!/bin/bash +x

#ubuntu22.04 bash路径为 /bin/bash,  当错写为 '#!/usr/bin/bash' 会导致报错信息不友好 :
#   exec $pdir/docker_entry.sh: no such file or directory
#      不是没有 docker_entry.sh ,  而是 docker_entry.sh 中写的 解释器 '#!/usr/bin/bash' 不存在


#【描述】  
#【依赖】   
#【术语】 
#【备注】   


#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

source $pdir/util/dkEntry.sh

#docker实例初始化
dkEntry #"$pdir/init_proj.sh" "$pdir/busz_run.sh" "$pdir/manual_txt.sh"

