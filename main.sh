#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 bsFlg=bashFlag
#【备注】   

#get_pdir 参考 http://giteaz:3000/bal/bash-simplify/src/branch/release/parseCallerN.sh
function get_pdir() {
#'$(caller 0)' == '12 main /app/app_env/main_dockerImage_build_run.sh'
pdir=$(dirname $(readlink -f $(echo $(caller 0) | cut -d' ' -f3) ) )
}

#进入目录 当前目录, 变量pdir为当前目录绝对路径
get_pdir && source $pdir/pre_init.sh || exit 70
# exit 0

#基本导入: 域名设置、_importBSFn
source $pdir/docker_instance.sh

_importBSFn arg1EqNMsg.sh
usage_txt="命令用法:main.sh useDocker=true|false bsFlg='-x|-xu|+x -u'. 比如 【main.sh true “bsFlg='+x -u'” 】"
#断言只有2个参数，否则打印命令用法
arg1EqNMsg $# 2 "$usage_txt"  || exit $?
_useDocker=$1
_bsFlgVarExpr=$2

#克隆必须仓库
source $pdir/util/repo_require.sh

#去此脚本所在目录
_importBSFn cdCurScriptDir.sh && cdCurScriptDir

_importBSFn mapBool2Txt.sh

#返回变量 useDocker
str2bool_notF2T $_useDocker "useDocker"
#返回变量 bsFlg
eval "$_bsFlgVarExpr"

function dockerDo() {

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune --force  # --all  

#docker免sudo
_importBSFn "docker_skip_sudo.sh" && docker_skip_sudo

source $pdir/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh

#宿主机 产物目录 创建
mk_gainD_host

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

source $pdir/util/convert_sh_to_Dockerfile__rmInst__rmImg__bldImg.sh

#构建基础镜像 
#  转换 ubuntu2204_proj.Dockerfile.sh ---> ubuntu2204_proj.Dockerfile ，停止、删除  实例 ， 删除、构建 镜像
convert_sh_to_Dockerfile__rmInst__rmImg__bldImg     $dkInstName $dkInstVer

# docker实例的volume映射
#若主机目录不存在或为空或为git仓库，则 必要时新建该目录 并 映射到docker实例. 修改变量 dkVolMap
#                                  宿主机的git仓库     docker实例中git仓库
dkVolMap_if_HDir_No_or_Empty_or_Git "$prjGRpD_host"  "$prjGRpD_dk"

#docker实例正常启动(交互式+终端+后台)
docker run $dk_privileged  --interactive --tty --detach  -e pdir="$pdir" -e bsFlg="$bsFlg" $dkVolMap  $dkPortMap  --name $dkInstName --hostname $dkInstName    $dkInstName:$dkInstVer /bin/bash
#初次:
#  'docker exec'指定运行dkMain.sh  :    init_proj.sh + busz_run.sh ;  
docker exec   $dkInstName /bin/bash  "$pdir/util/dkMain.sh"
#日常:
#  以后日常'docker exec'都只需要运行bash而不再需要运行dkMain.sh
docker exec   $dkInstName /bin/bash  --init-file $pdir/bashrc.sh 
}


function hostDo() {
pdir="$pdir" bsFlg="$bsFlg" bash $bsFlg $pdir/ubuntu2204_proj.Dockerfile.sh
pdir="$pdir" bsFlg="$bsFlg"    bash $bsFlg $pdir/util/dkMain.sh
}

#若指定用docker，则执行函数 dockerDo 并退出
$useDocker && { dockerDo ; exit $? ;}

#若指定不用docker，则执行函数 hostDo 并退出
$useDocker || { hostDo ; exit $? ;}