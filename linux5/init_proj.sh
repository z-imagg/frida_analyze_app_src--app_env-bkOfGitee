#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 
#    1. 此脚本 被docker实例(运行ubuntu16.04) 执行
#    2. 此脚本 在宿主机ubuntu16.04下运行 (未验证)

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

source  <(curl --silent http://g:3000/bal/bash-simplify/raw/branch/release/git_ignore_filemode.sh)
source  <(curl --silent http://g:3000/bal/bash-simplify/raw/branch/release/git_switch_to_remote_tag.sh)
# #region 项目

#   #region 项目代码拉取

#本项目  代码拉取
#  删除 构建Dockerfile时 用的目录 /fridaAnlzAp/prj_env/env
mv /fridaAnlzAp /tmp_fridaAnlzAp ; mkdir -p /fridaAnlzAp/
LnxVer="v5.11"
# docker实例中linux仓库路径
dkLnxRpD="/app/linux"
# docker实例中是否有linux仓库
dkHasLnxRp=false ; [[ -f $dkLnxRpD/.git/config ]] && dkHasLnxRp=true
# 若 docker实例中无linux仓库， 则 克隆该仓库
$dkHasLnxRp || git clone -b $LnxVer https://mirrors.ustc.edu.cn/linux.git  $dkLnxRpD
#git项目忽略文件权限变动
( cd $dkLnxRpD ; git_ignore_filemode ;)
# 若当前提交 上 无 标签v5.11 , 则 切换到 标签v5.11 
git_switch_to_remote_tag $dkLnxRpD v5.11


ls -lh /

#   #endregion

# #endregion
