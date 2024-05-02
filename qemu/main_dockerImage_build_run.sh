#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#当长久build docker镜像后，需要清理docker占用的磁盘空间
docker system prune --force  # --all  

#基本需求: 域名设置、克隆基本仓库
source /fridaAnlzAp/app_qemu/app_bld/util/basic_require.sh

#重建 供给docker build用的根目录
source /fridaAnlzAp/app_bld/util/hostRootReCreate4DkBuild.sh

#docker免sudo
_importBSFn "docker_skip_sudo.sh" && docker_skip_sudo

source /fridaAnlzAp/app_bld/util/dkVolMap_if_HDir_Git.sh
source /fridaAnlzAp/app_bld/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh
source /fridaAnlzAp/app_bld/util/dkVolMap__asstHstGitD.sh
source /fridaAnlzAp/app_bld/util/dkVolMap_gain_def.sh

#若宿主机 产物目录 创建
mk_gainD_host

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/qemu/docker_instance.sh

source /fridaAnlzAp/app_bld/util/convert_sh_to_Dockerfile__rmInst__rmImg__bldImg.sh

#构建基础镜像 
#  转换 ubuntu2204_linux5build.Dockerfile.sh ---> ubuntu2204_linux5build.Dockerfile ，停止、删除  实例 ， 删除、构建 镜像
convert_sh_to_Dockerfile__rmInst__rmImg__bldImg    $dkInstName $dkInstVer

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
