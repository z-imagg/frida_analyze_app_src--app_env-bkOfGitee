#!/usr/bin/bash -x

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27

source  <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_switch_to_remote_tag.sh)

LnxVer="v5.11"
dkLnxRpD="/app/linux"

#docker实例运行的时候，才克隆项目代码，方便docker image上传到dockerhub ，同时也不泄漏项目源码
# 若初次启动时，则 克隆项目代码 并 退出
git_switch_to_remote_tag "$dkLnxRpD" "$LnxVer" 2>/dev/null || { bash -x /fridaAnlzAp/app_qemu/app_bld/linux5/init_proj.sh && exit 0 ;}

# 若非初次启动，则启动bash
cd $dkLnxRpD && /usr/bin/bash


