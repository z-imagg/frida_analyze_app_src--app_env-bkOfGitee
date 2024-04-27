#!/usr/bin/bash -x

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e


#docker实例运行的时候，才克隆项目代码，方便docker image上传到dockerhub ，同时也不泄漏项目源码
# 若初次启动时，则 克隆项目代码 并 退出
[[ -f /app/linux/.git/config ]] || { bash +x /fridaAnlzAp/app_qemu/app_bld/linux5/init_proj.sh && exit 0 ;}

# 若非初次启动，则启动bash
cd /app/linux/ && /usr/bin/bash


