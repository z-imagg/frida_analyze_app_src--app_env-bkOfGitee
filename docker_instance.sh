#!/bin/bash

#【描述】  定义 docker镜像、实例 的 名称、版本号
#【依赖】   
#【术语】 
#【备注】   

#主机 项目git仓库目录
prjGRpD_host="/app/linux"
#docker实例 项目git仓库目录
prjGRpD_dk="/app/linux"
#项目git仓库标签
prjGRp_tag="v5.11"
#项目git仓库url
prjGRp_url="https://mirrors.ustc.edu.cn/linux.git" 

#项目名称 linux_v5.11_build
projNm="linux_${prjGRp_tag}_build"

#app_env 所用标签 tag_release__linux_v5.11_build
app_env__tag="tag_release__${projNm}"

#名称, 用作 docker镜像名称 、 docker实例名称
dkInstName="ubuntu2204_${projNm}"
#版本号, 用作 docker镜像版本号 、 docker实例版本号
dkInstVer="0.1"

