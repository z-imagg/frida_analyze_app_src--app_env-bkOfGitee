#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   


_importBSFn "git__chkDir__get__repoDir__arg_gitDir.sh"
_importBSFn "argCntEq2.sh"
_importBSFn "bool_not.sh"


#若主机目录为git仓库，则映射该目录到docker实例; 否则，不映射。始终返回成功
# 修改变量 dkVolMap
function dkVolMap_if_HDir_Git() {
local OK_exitCode=0
local _dkVolMap="$dkVolMap --volume $hostRepoDir:$dkRepoDir"

argCntEq2 $* || return $?
# 宿主机的git仓库  ; #docker实例中qemu仓库
local hostRepoDir=$1 ; local dkRepoDir=$2

# 主机目录 是否 为合法git仓库
local hostDirIsGitReop=false; git__chkDir__get__repoDir__arg_gitDir "$hostRepoDir" && hostDirIsGitReop=true;
# 主机目录 是否 不为合法git仓库
local hostDirNotGitReop; bool_not $hostDirIsGitReop "hostDirNotGitReop"

#若 主机目录 是 合法git仓库 ， 则  映射该目录到docker实例  并    正常返回
$hostDirIsGitReop && dkVolMap="$_dkVolMap" &&  return $OK_exitCode
#否则，                     则   正常返回
$hostDirNotGitReop && return $OK_exitCode


#dkVolMap="..." 是 更改全局变量
}

#使用举例
# _importBSFn "dkVolMap_if_HDir_Git.sh"
#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
# dkVolMap_if_HDir_Git "/app/qemu" "/root/qemu"