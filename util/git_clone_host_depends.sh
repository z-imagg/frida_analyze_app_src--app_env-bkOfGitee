#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

_importBSFn "mkMyDirBySudo.sh"
_importBSFn "git_Clone_SwitchTag.sh"

#docker实例初始化
function git_clone_host_depends() {
local AppHm="/app"
local bashSimply="/app/bash-simplify"

#若非目录， 则新建之。 有 漏洞 ，比如 其可能是文件， 忽略此漏洞
[[ -d $AppHm ]] || mkMyDirBySudo $AppHm

#克隆仓库的给定标签到本地目录 或 切换本地仓库到给定标签
git_Clone_SwitchTag http://giteaz:3000/bal/bash-simplify.git "tag_release" "$bashSimply"

}

# 使用举例
# source /fridaAnlzAp/app_qemu/app_bld/util/git_clone_host_depends.sh && git_clone_host_depends