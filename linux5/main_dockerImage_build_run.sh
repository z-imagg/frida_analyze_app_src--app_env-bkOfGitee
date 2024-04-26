#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh

#去此脚本所在目录
source /bal/bash-simplify/cdCurScriptDir.sh && cdCurScriptDir


#构建基础镜像 
#  转换 ase_ubuntu_16.04.Dockerfile.sh ---> ase_ubuntu_16.04.Dockerfile  、 删除 、 构建docker镜像
convert_sh_to_Dockerfile__rmInst__rmImage    ubuntu1604Lnx5Bld 0.1  ;  docker build --progress=plain --no-cache  -f "ubuntu1604Lnx5Bld.Dockerfile" -t ubuntu1604Lnx5Bld:0.1 "/" 


# 若初次启动时，则 克隆项目代码 并 退出
docker run --privileged=true  --name ubuntu1604Lnx5Bld --hostname ubuntu1604Lnx5Bld -it ubuntu1604Lnx5Bld:0.1
# 退出后，再次启动
docker start ubuntu1604Lnx5Bld
docker exec -it ubuntu1604Lnx5Bld  /usr/bin/bash
