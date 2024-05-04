#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#get_pdir 参考 http://giteaz:3000/bal/bash-simplify/src/branch/release/parseCallerN.sh
function get_pdir() {
#'$(caller 0)' == '12 main /app/app_env/main_dockerImage_build_run.sh'
pdir=$(dirname $(readlink -f $(echo $(caller 0) | cut -d' ' -f3) ) )
}

#进入目录 当前目录, 变量pdir为当前目录绝对路径
get_pdir && source $pdir/pre_init.sh || exit 70
# exit 0

#基本需求:  导入 _importBSFn.sh、 域名设置、克隆基本仓库
source $pdir/util/basic_require.sh

#克隆宿主机中需要的依赖仓库
source $pdir/util/git_clone_host_depends.sh && git_clone_host_depends

#去此脚本所在目录
_importBSFn cdCurScriptDir.sh && cdCurScriptDir

#断言只有1个参数，否则打印命令用法
_importBSFn arg1EqNMsg.sh && { arg1EqNMsg $# 1 "命令用法:main.sh useDocker=true|false. 比如 'main.sh true'"  || return $? ;}
_useDocker=$1
#一切非false的字符串都被当作true
useDocker=true; [[ "X$_useDocker" -eq "Xfalse" ]] && useDocker=false

function dockerDo() {

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune --force  # --all  

#docker免sudo
_importBSFn "docker_skip_sudo.sh" && docker_skip_sudo

source $pdir/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh
source $pdir/util/dkVolMap_gain_def.sh

#宿主机 产物目录 创建
mk_gainD_host

#重建 供给docker build用的根目录
source $pdir/util/hostRootReCreate4DkBuild.sh

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

source $pdir/util/convert_sh_to_Dockerfile__rmInst__rmImg__bldImg.sh

#构建基础镜像 
#  转换 ubuntu2204_linux5build.Dockerfile.sh ---> ubuntu2204_linux5build.Dockerfile ，停止、删除  实例 ， 删除、构建 镜像
convert_sh_to_Dockerfile__rmInst__rmImg__bldImg    $dkInstName $dkInstVer

# docker实例的volume映射
dkVolMap="${dkVolMap_gain}"

#若主机目录不存在或为空或为git仓库，则 必要时新建该目录 并 映射到docker实例. 修改变量 dkVolMap
#                                  宿主机的git仓库   docker实例中git仓库
dkVolMap_if_HDir_No_or_Empty_or_Git "/app/linux" "/app/linux"

# 若初次启动时，则 克隆项目代码 并 退出
#  最终调用 init_proj.sh , 再以busz_run.sh启动bash
docker run -e isDkInitProj='true' -e isDkBuszRun='true' -e pdir="$pdir" $dkVolMap  --name $dkInstName --hostname $dkInstName  --interactive  --tty  $dkInstName:$dkInstVer
}

#若指定用docker，则执行函数 dockerDo 并退出
$useDocker && { dockerDo ; exit $? ;}

#若指定不用docker，则执行脚本 .Dockerfile.sh 并退出
$useDocker || { pdir="$pdir" bash -x $pdir/ubuntu2204_linux5build.Dockerfile.sh; exit $? ;}