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

source /fridaAnlzAp/app_qemu/app_bld/util/git_Clone_SwitchTag.sh

#克隆仓库qemu版本v5.0.0
git_Clone_SwitchTag "https://github.com/qemu/qemu.git"  "v5.0.0"  "/app/qemu"

#克隆仓库cmd-wrap版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/bal/cmd-wrap.git"  "tag_release"  "/app/cmd-wrap"

# cmd-wrap环境初始化
bash "$cmdWrap_dkRpD/script/env_prepare.sh"


#docker首次运行，初始化完毕后 显示相关目录
# 存在的路径
# echo "告知存在的路径,非错误" ; ls /   /app /tmp_fridaAnlzAp/ /fridaAnlzAp/      /app/linux/.git/config   || true
# # 不存在的路径
# echo "告知不存在路径,非错误" ; ls /app/bash-simplify/.git  /tmp_fridaAnlzAp/prj_env/.git /tmp_fridaAnlzAp/app_qemu/.git || true

