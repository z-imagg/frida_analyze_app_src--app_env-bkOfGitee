#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e


source  <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_switch_to_remote_tag.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git_clone_branchOrTag_toDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEqN.sh)

#克隆仓库、子模块更新、git忽略文件权限变动，切换到远程标签
function git_Clone_SwitchTag() {
#断言参数个数为3个
echo 3 | argCntEqN $* || return $?

#git仓库Url
local repoUrl=$1
#初始分支名称
local Ver=$2
#git仓库存放目录
local repoDir=$3

#  克隆 qeum仓库 目的标签 到 给定目录
#     若本地目录已经该仓库，因可能不在该标签，因此 接下来需要 切换标签
git_clone_branchOrTag_toDir $repoUrl $Ver $repoDir
# 切换到 目的标签
git_switch_to_remote_tag $repoDir $Ver

}
