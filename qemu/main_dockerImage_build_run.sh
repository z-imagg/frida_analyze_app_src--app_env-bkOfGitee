#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27

source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_if_HDir_Git.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_gain.sh

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

#若主机目录不存在或为空或为git仓库，则映射该目录到docker实例. 修改变量 dkVolMap
#                                  宿主机的git仓库   docker实例中git仓库
dkVolMap_if_HDir_No_or_Empty_or_Git "/app/qemu" "/app/qemu"

#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
dkVolMap_if_HDir_Git "/app/cmd-wrap" "/app/cmd-wrap"
# dkVolMap_if_HDir_Git "/app/bash-simplify" "/app/bash-simplify"

#若宿主机无linux仓库，即无linux编译产物，则返回错误。 否则，映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
dkVolMap__asstHstGitD "/app/linux" "/app/linux"

#若初次启动时，则 克隆项目代码 并 退出
docker run --privileged=true -e isDkInstInit='true' -e isDkBuszRun='true' $dkVolMap  --name $dkInstName --hostname $dkInstName --interactive  --tty $dkInstName:$dkInstVer
