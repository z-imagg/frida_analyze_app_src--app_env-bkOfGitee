#!/bin/bash

#【描述】  定义 docker镜像、实例 的 名称、版本号
#【依赖】   
#【术语】 Nm==Name, prjGRpD == projectGitRepoDir == 项目git仓库目录
#【备注】   

prjNm="hello_world"

#主机 项目git仓库目录
prjGRpD_host="/app/${prjNm}"
#docker实例 项目git仓库目录
prjGRpD_dk="/app/${prjNm}"
#项目git仓库标签
prjTag="tag_v1"
#项目git仓库url
prjGRp_url="https://gitee.com/repok/hello_world.git" 

#环境主题
envTopic="demo"

#环境名称 项目名称_项目版本_
envNm="${prjNm}_${prjTag}_${envTopic}"

#app_env 所用标签 tag_release__项目名称_项目版本_环境主题
app_env__tag="tag_release__${envNm}"

#名称, 用作 docker镜像名称 、 docker实例名称
dkInstName="ubuntu2204_${envNm}"
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

