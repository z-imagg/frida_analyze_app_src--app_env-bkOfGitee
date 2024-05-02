#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 
#    1. 此脚本 被docker实例(运行ubuntu22.04) 执行
#    2. 此脚本 在宿主机ubuntu22.04下运行 (未验证)

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#基本需求: 域名设置、克隆基本仓库
source $pdir/util/basic_require.sh

_importBSFn "git_Clone_SwitchTag.sh"

#克隆仓库linux版本v5.11
git_Clone_SwitchTag "https://mirrors.ustc.edu.cn/linux.git"  "v5.11"  "/app/linux"


