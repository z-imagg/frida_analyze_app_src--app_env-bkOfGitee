#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/dkVolMap__if_hostGitDir.sh)

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/qemu/docker_instance.sh

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh

#构建基础镜像 
#  转换 ubuntu2204_qemu500build.Dockerfile.sh ---> ubuntu2204_qemu500build.Dockerfile  、 删除 、 构建docker镜像
convert_sh_to_Dockerfile__rmInst__rmImage    $dkInstName $dkInstVer  ;  docker build --progress=plain --no-cache  -f "$dkInstName.Dockerfile" -t $dkInstName:$dkInstVer "/" 

# docker实例的volume映射
dkVolMap=""

# docker实例中qemu仓库  ; #宿主机的git仓库
qemu_dkRpD="/app/qemu";  qemu_hostRpD="/app/qemu"
#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
dkVolMap__if_hostGitDir $qemu_hostRpD $qemu_dkRpD

# docker实例中cmd-wrap仓库  ; #宿主机的git仓库
cmdWrap_dkRpD="/app/cmd-wrap";  cmdWrap_hostRpD="/app/cmd-wrap"
#若宿主机有git仓库，则映射到docker实例中. 修改变量 dkVolMap
dkVolMap__if_hostGitDir $qemu_hostRpD $qemu_dkRpD

#若初次启动时，则 克隆项目代码 并 退出
docker run -e isDkInstInit='true' $dkVolMap  --name $dkInstName --hostname $dkInstName -it $dkInstName:$dkInstVer
