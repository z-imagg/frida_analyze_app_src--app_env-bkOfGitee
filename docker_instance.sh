#!/bin/bash

#【描述】  定义 docker镜像、实例 的 名称、版本号
#【依赖】   
#【术语】 
#【备注】   

#主机 项目git仓库目录
prjGRpD_host="/app/qemu"
#docker实例 项目git仓库目录
prjGRpD_dk="/app/qemu"
#项目git仓库标签
prjGRp_tag="v5.11"
#项目git仓库url
prjGRp_url="https://mirrors.ustc.edu.cn/linux.git" 

#项目名称
projNm="qemu500build"

#名称, 用作 docker镜像名称 、 docker实例名称
dkInstName="ubuntu2204_${projNm}"
#版本号, 用作 docker镜像版本号 、 docker实例版本号
dkInstVer="0.1"

