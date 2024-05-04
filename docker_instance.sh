#!/bin/bash

#【描述】  定义 docker镜像、实例 的 名称、版本号
#【依赖】   
#【术语】 prjGRpD == projectGitRepoDir == 项目git仓库目录
#【备注】   

#主机 项目git仓库目录
prjGRpD_host="/app/qemu"
#docker实例 项目git仓库目录
prjGRpD_dk="/app/qemu"
#项目git仓库标签
prjGRp_tag="v5.11"
#项目git仓库url
prjGRp_url="https://mirrors.ustc.edu.cn/linux.git" 

#项目名称 qemu_v8.2.2_build
projNm="qumu_${prjGRp_tag}_build"

#app_env 所用标签 tag_release__linux_v5.11_build
app_env__tag="tag_release__${projNm}"

#名称, 用作 docker镜像名称 、 docker实例名称
dkInstName="ubuntu2204_${projNm}"
#版本号, 用作 docker镜像版本号 、 docker实例版本号
dkInstVer="0.1"

#项目git仓库目录
source /app/bash-simplify/_importBSFn.sh
prjGRpD=""
#判定当前 是在docker实例中 还是 在 宿主物理机 中  .  返回变量为 inDocker
_importBSFn "isInDocker.sh" && isInDocker
#  若在docker实例中 ，计算prjGRpD
$inDocker && prjGRpD=$prjGRpD_dk
#  若在宿主机中 ，计算prjGRpD
$inDocker || prjGRpD=$prjGRpD_host

