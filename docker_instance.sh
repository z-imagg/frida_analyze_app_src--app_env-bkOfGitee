#!/bin/bash

#【描述】  定义 docker镜像、实例 的 名称、版本号
#【依赖】   
#【术语】 Nm==Name, prjGRpD == projectGitRepoDir == 项目git仓库目录, dk==docker
#【备注】   

#此脚本只引入一次
#  若未定义变量...,则进入
#      bash请务必设置-u以不允许使用未定义变量
if [[ ! -v  _loaded__docker_instance ]]; then
#标记此脚本是否已引入
_loaded__docker_instance=true

#定义项目配置
# 项目名称中不允许都大写字母, 因为其作为docker img名称的一部分了, 而docker img名称不允许有大写字母
prjNm="hello-world"
# 主机 项目git仓库目录
prjGRpD_host="/app/${prjNm}"
# docker实例 项目git仓库目录
prjGRpD_dk="/app/${prjNm}"
# 项目git仓库标签
prjTag="v1"
# 项目git仓库url
prjGRp_url="https://gitee.com/repok/hello_world.git" 
# 环境主题
envTopic="demo"
# 环境名称 项目名称_项目版本_
envNm="${prjNm}_${prjTag}_${envTopic}"
# app_env 所用标签 tag_release__hello-world_v1_demo
app_env__tag="tag_release__${envNm}"
# 名称, 用作 docker镜像名称 、 docker实例名称
dkInstName="ubuntu2204_${envNm}"
# 版本号, 用作 docker镜像版本号 、 docker实例版本号
dkInstVer="0.1"


#docker实例 port配置
# dk实例 port配置: ssh 宿主机端口:dk实例端口
_dkPortMap_ssh="--publish 122:22"
#dk实例 port配置
dkPortMap="$_dkPortMap_ssh"

#docker实例 volume配置
#docker volume映射 : 产物目录
# 宿主机 产物目录
gainD_host="/gain"
# dk实例 产物目录
gainD_dk="/gain"
#                  宿主机目录   : dk实例目录
dkVolMap="--volume $gainD_host:$gainD_dk"

#docker实例 privileged配置
dk_privileged=""
#比如 --privileged=true

#导入必须包
# 本地域名总是要设置的
source $pdir/util/LocalDomainSet.sh
# 导入_importBSFn.sh
source /app/bash-simplify/_importBSFn.sh
_importBSFn "git_Clone_SwitchTag.sh"

#宿主机 产物目录 创建
_importBSFn "mkMyDirBySudo.sh"
function mk_gainD_host() {
#宿主机 产物目录 创建
mkMyDirBySudo $gainD_host
}

#引入必须量
# 判定当前 是在docker实例中 还是 在 宿主物理机 中  .  返回变量为 inDocker
_importBSFn "isInDocker.sh" && isInDocker

#计算量
# 项目git仓库目录
prjGRpD=""
#   若在docker实例中 ，计算prjGRpD
$inDocker && prjGRpD=$prjGRpD_dk
#   若在宿主机中 ，计算prjGRpD
$inDocker || prjGRpD=$prjGRpD_host


#此脚本正文结束
fi
