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

# #region 项目

#   #region 项目代码拉取

#本项目  代码拉取
#  删除 构建Dockerfile时 用的目录 /fridaAnlzAp/prj_env/env
mv /fridaAnlzAp /tmp_fridaAnlzAp ; mkdir -p /fridaAnlzAp/
git clone -b v5.11 https://mirrors.ustc.edu.cn/linux.git  /fridaAnlzAp/app/linux/
#git项目忽略文件权限变动
( cd /fridaAnlzAp/app/linux/ ; git_ignore_filemode ;)

ls -lh /

#   #endregion

# #endregion
