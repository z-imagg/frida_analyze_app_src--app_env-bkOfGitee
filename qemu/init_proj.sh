#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 
#    1. 此脚本 被docker实例(运行ubuntu16.04) 执行
#    2. 此脚本 在宿主机ubuntu16.04下运行 (未验证)

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27

source  <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode.sh)
source  <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_switch_to_remote_tag.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_clone_branchOrTag_toDir.sh)


dkRpD="/app/qemu"
Ver="v5.0.0"
#  克隆 https://github.com/qemu/qemu.git 的标签 v5.0.0 到 本地目录 /app/qemu/ 
git_clone_branchOrTag_toDir https://github.com/qemu/qemu.git $Ver $dkRpD
# 若当前提交 上 无 标签v5.11 , 则 切换到 标签v5.11 
git_switch_to_remote_tag $dkRpD $Ver


#docker首次运行，初始化完毕后 显示相关目录
# 存在的路径
# echo "告知存在的路径,非错误" ; ls /   /app /tmp_fridaAnlzAp/ /fridaAnlzAp/      /app/linux/.git/config   || true
# # 不存在的路径
# echo "告知不存在路径,非错误" ; ls /app/bash-simplify/.git  /tmp_fridaAnlzAp/prj_env/.git /tmp_fridaAnlzAp/app_qemu/.git || true

