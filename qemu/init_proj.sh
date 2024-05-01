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

#基本需求: 域名设置、克隆基本仓库
source /fridaAnlzAp/app_qemu/prj_env/util/basic_require.sh


_importBSFn "gitproxy_Clone_SwitchTag.sh"
_importBSFn "git_Clone_SwitchTag.sh"

#克隆仓库qemu版本v8.2.2
gitproxy_Clone_SwitchTag "https://github.com/qemu/qemu.git"  "v8.2.2"  "/app/qemu"

# cmd-wrap环境初始化
bash "/app/cmd-wrap/script/env_prepare.sh"


#docker首次运行，初始化完毕后 显示相关目录
# 存在的路径
# echo "告知存在的路径,非错误" ; ls /   /app /tmp_fridaAnlzAp/ /fridaAnlzAp/      /app/linux/.git/config   || true
# # 不存在的路径
# echo "告知不存在路径,非错误" ; ls /app/bash-simplify/.git  /tmp_fridaAnlzAp/prj_env/.git /tmp_fridaAnlzAp/app_qemu/.git || true

