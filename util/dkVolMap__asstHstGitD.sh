#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq2.sh)

#断言主机目录为git仓库 并 映射该目录到docker实例
#若主机目录为git仓库，则映射该目录到docker实例; 否则返回失败
# 修改变量 dkVolMap
function dkVolMap_HDir_assertGit() {


#暂时将映射结果写入局部变量
local _dkVolMap="$dkVolMap --volume $hostRepoDir:$dkRepoDir"

local OK_exitCode=0

argCntEq2 $* || return $?
# 宿主机的git仓库  ; #docker实例中qemu仓库
local hostRepoDir=$1 ; local dkRepoDir=$2

local errCode=255
local assertTxt="【断言失败原因】宿主机中必须存在目录${hostRepoDir}且为git仓库"

#若主机目录不是合法git仓库，                                则返回错误。 
git__chkDir__get__repoDir__arg_gitDir "$hostRepoDir"  || { errCode=$? ; echo $assertTxt ; return $errCode ;}
#否则 docker实例映射该目录
dkVolMap="$_dkVolMap"

#dkVolMap="..." 是 更改全局变量
}

#使用举例
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/dkVolMap_HDir_assertGit.sh)
#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
# dkVolMap_HDir_assertGit "/app/qemu" "/root/qemu"
