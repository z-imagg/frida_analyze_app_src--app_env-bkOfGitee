#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   


source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/git__chkDir__get__repoDir__arg_gitDir.sh)
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/argCntEq2.sh)


#产生docker volume映射 :  若存在 宿主机git仓库目录  则映射为 docker实例仓库目录
# 修改变量 dkVolMap
function dkVolMap__if_hostGitDir() {
argCntEq2 $* || return $?
# 宿主机的git仓库  ; #docker实例中qemu仓库
local hostRepoDir=$1 ; local dkRepoDir=$2
#  若该目录不是合法git仓库， 则 返回错误。                                    否则  docker实例映射该目录
{ git__chkDir__get__repoDir__arg_gitDir "$hostRepoDir" || return $? ;} && dkVolMap="$dkVolMap --volume $hostRepoDir:$dkRepoDir"
#更改全局变量 dkVolMap
}

#使用举例
# source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/dkVolMap__if_hostGitDir.sh)
#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
# dkVolMap__if_hostGitDir "/app/qemu" "/root/qemu"