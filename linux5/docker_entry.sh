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


#docker实例初始化
function dkInstInit() {

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27

#docker实例运行的时候，才克隆项目代码，方便docker image上传到dockerhub ，同时也不泄漏项目源码
#  克隆项目代码
bash +x /fridaAnlzAp/app_qemu/app_bld/linux5/init_proj.sh

}

LnxVer="v5.11"
dkLnxRpD="/app/linux"

# 若docker实例初次运行时，则 进行初始化
$isDkInstInit && dkInstInit

# 进入bash
#  调用.bashrc
/bin/bash --rcfile /root/.bashrc


