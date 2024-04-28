#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#去此脚本所在目录
source /app/bash-simplify/cdCurScriptDir.sh && cdCurScriptDir

source /fridaAnlzAp/app_qemu/app_bld/util/dkVolMap__if_hostGitDir.sh

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/linux5/docker_instance.sh

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh


#构建基础镜像 
#  转换 ubuntu2204_linux5build.Dockerfile.sh ---> ubuntu2204_linux5build.Dockerfile  、 删除 、 构建docker镜像
convert_sh_to_Dockerfile__rmInst__rmImage    $dkInstName $dkInstVer  ;  docker build --progress=plain --no-cache  -f "$dkInstName.Dockerfile" -t $dkInstName:$dkInstVer "/" 

# docker实例的volume映射
dkVolMap=""

#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
#                        宿主机的git仓库   docker实例中cmd-wrap仓库
dkVolMap__if_hostGitDir "/bal/linux-stable" "/app/linux"

# 若初次启动时，则 克隆项目代码 并 退出
docker run -e isDkInstInit='true' $dkVolMap  --name $dkInstName --hostname $dkInstName --interactive  --tty  $dkInstName:$dkInstVer
# 退出后， 若docker实例已停止 则 再次启动docker_entry.sh
# docker ps --filter "name=$dkInstName" | grep $dkInstName || { docker start --attach  --interactive $dkInstName    ;}
