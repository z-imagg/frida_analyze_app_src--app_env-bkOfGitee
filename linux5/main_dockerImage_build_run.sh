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

#克隆宿主机中需要的依赖仓库
source /fridaAnlzAp/app_qemu/app_bld/util/git_clone_host_depends.sh && git_clone_host_depends

#去此脚本所在目录
source /app/bash-simplify/cdCurScriptDir.sh && cdCurScriptDir

source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_if_HDir_No_or_Empty_or_Git.sh
source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap_gain_def.sh

#若宿主机 产物目录 创建
mk_gainD_host

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/linux5/docker_instance.sh

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh


#构建基础镜像 
#  转换 ubuntu2204_linux5build.Dockerfile.sh ---> ubuntu2204_linux5build.Dockerfile  、 删除 、 构建docker镜像
convert_sh_to_Dockerfile__rmInst__rmImage    $dkInstName $dkInstVer  ;  docker build --progress=plain --no-cache  -f "$dkInstName.Dockerfile" -t $dkInstName:$dkInstVer "/" 

# docker实例的volume映射
dkVolMap="${dkVolMap_gain}"

#若主机目录不存在或为空或为git仓库，则 必要时新建该目录 并 映射到docker实例. 修改变量 dkVolMap
#                                  宿主机的git仓库   docker实例中git仓库
dkVolMap_if_HDir_No_or_Empty_or_Git "/app/linux" "/app/linux"

# 若初次启动时，则 克隆项目代码 并 退出
#  最终调用 init_proj.sh , 再以busz_run.sh启动bash
docker run -e isDkInstInit='true' -e isDkBuszRun='true' $dkVolMap  --name $dkInstName --hostname $dkInstName  --interactive  --tty  $dkInstName:$dkInstVer