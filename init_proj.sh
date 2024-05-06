#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 
#    1. 此脚本 被docker实例(运行ubuntu22.04) 执行
#    2. 此脚本 在宿主机ubuntu22.04下运行 (未验证)

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#导入配置
source $pdir/docker_instance.sh

#基本需求: 域名设置、克隆基本仓库
source $pdir/util/repo_require.sh

_importBSFn "git_Clone_SwitchTag.sh"

#克隆 项目仓库 的 给定标签 到 docker实例中给定目录
git_Clone_SwitchTag "$prjGRp_url"  "$prjTag"  "$prjGRpD_dk"


