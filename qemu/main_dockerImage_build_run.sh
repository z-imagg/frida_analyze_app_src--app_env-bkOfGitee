#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#本地域名总是要设置的
source /fridaAnlzAp/app_qemu/app_bld/util/LocalDomainSet.sh
#导入_importBSFn.sh
source /fridaAnlzAp/app_qemu/app_bld/util/Load__importBSFn.sh

#docker免sudo
_importBSFn "docker_skip_sudo.sh" && docker_skip_sudo

source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_if_HDir_Git.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap__asstHstGitD.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_gain_def.sh

#若宿主机 产物目录 创建
mk_gainD_host

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/qemu/docker_instance.sh

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh

#构建基础镜像 
#  转换 ubuntu2204_qemu500build.Dockerfile.sh ---> ubuntu2204_qemu500build.Dockerfile  、 删除 、 构建docker镜像
convert_sh_to_Dockerfile__rmInst__rmImage    $dkInstName $dkInstVer  ;  docker build --progress=plain --no-cache  -f "$dkInstName.Dockerfile" -t $dkInstName:$dkInstVer "/" 

# docker实例的volume映射
dkVolMap="${dkVolMap_gain}"

#若主机目录不存在或为空或为git仓库，则 必要时新建该目录 并 映射到docker实例。始终返回成功. 修改变量 dkVolMap
#                                  宿主机的git仓库   docker实例中git仓库
dkVolMap_if_HDir_No_or_Empty_or_Git "/app/qemu" "/app/qemu"

#若主机目录为git仓库，则映射该目录到docker实例; 否则，不映射。始终返回成功. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
dkVolMap_if_HDir_Git "/app/cmd-wrap" "/app/cmd-wrap"
# dkVolMap_if_HDir_Git "/app/bash-simplify" "/app/bash-simplify"

#断言主机目录为git仓库 并 映射该目录到docker实例. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
dkVolMap__asstHstGitD "/app/linux" "/app/linux"

#若初次启动时，则 克隆项目代码 并 退出
docker run --privileged=true -e isDkInstInit='true' -e isDkBuszRun='true' $dkVolMap  --name $dkInstName --hostname $dkInstName --interactive  --tty $dkInstName:$dkInstVer
