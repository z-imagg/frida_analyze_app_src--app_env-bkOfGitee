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

#克隆仓库qemu
qemu_dkRpD="/app/qemu"
qemu_Ver="v5.0.0"
#  克隆 qeum仓库 目的标签 到 给定目录
git_clone_branchOrTag_toDir https://github.com/qemu/qemu.git $qemu_Ver $qemu_dkRpD
# 切换到 目的标签
git_switch_to_remote_tag $qemu_dkRpD $qemu_Ver

#克隆仓库cmd-wrap
cmdWrap_dkRpD="/app/cmd-wrap"
cmdWrap_Ver="tag_release"
#  克隆 cmdWrap仓库 目的标签 到 给定目录
git_clone_branchOrTag_toDir http://giteaz:3000/bal/cmd-wrap.git $cmdWrap_Ver $cmdWrap_dkRpD
# 切换到 目的标签
git_switch_to_remote_tag $cmdWrap_dkRpD $cmdWrap_Ver
# cmd-wrap环境初始化
source "$cmdWrap_dkRpD/script/env_prepare.sh"


#docker首次运行，初始化完毕后 显示相关目录
# 存在的路径
# echo "告知存在的路径,非错误" ; ls /   /app /tmp_fridaAnlzAp/ /fridaAnlzAp/      /app/linux/.git/config   || true
# # 不存在的路径
# echo "告知不存在路径,非错误" ; ls /app/bash-simplify/.git  /tmp_fridaAnlzAp/prj_env/.git /tmp_fridaAnlzAp/app_qemu/.git || true

