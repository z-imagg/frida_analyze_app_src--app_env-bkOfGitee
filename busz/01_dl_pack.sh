#!/usr/bin/bash

#【描述】  下载包 、 解压包 
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e -u

#导入配置
source $pdir/docker_instance.sh

declare -r errMsg5="无目录/app/pack，请手工创建并设置主人为当前用户,退出代码5"
[[ -d /app/pack/ ]] || {  echo "$errMsg5" && exit 5 ;}

source /app/bash-simplify/download_unpack_simple.sh
#使用举例:download_unpack_simple https://neo4j.com/artifact.php?name=neo4j-community-4.4.32-unix.tar.gz a88d5de65332d9a5acbe131f60893b55  neo4j-community-4.4.32-unix.tar.gz  /tmp/pack/  /tmp/

#下载 miniconda3
F="Miniconda3-py310_22.11.1-1-Linux-x86_64.sh" ; download_unpack_simple https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/$F e01420f221a7c4c6cde57d8ae61d24b5  $F /app/pack/ /app/  
#下载 neo4j-4.4.32
F="neo4j-community-4.4.32-unix.tar.gz" ; download_unpack_simple https://neo4j.com/artifact.php?name=$F a88d5de65332d9a5acbe131f60893b55  $F /app/pack/ /app/ 
#下载 jdk11（被neo4j-4.4.32需要）
F="zulu11.70.15-ca-jdk11.0.22-linux_x64.tar.gz" ; download_unpack_simple https://cdn.azul.com/zulu/bin/$F f13d179f8e1428a3f0f135a42b9fa75b  $F /app/pack/ /app/ 
#下载 apoc（neo4j插件）
F="apoc-4.4.0.26-all.jar" ;   download_unpack_simple https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/4.4.0.26/$F 5a42a32e12432632124acd682382c91d  $F /app/pack/ /app/ 
#下载 cytoscape-3.10.2   .       https://github.com/cytoscape/cytoscape/releases/tag/3.10.2
F="cytoscape-unix-3.10.2.tar.gz" ;   download_unpack_simple https://github.com/cytoscape/cytoscape/releases/download/3.10.2/$F a6b5638319b301bd25e0e6987b3e35fd  $F /app/pack/ /app/ 
#下载 jdk17（被cytoscape-3.10.2需要）
F="zulu17.48.15-ca-jdk17.0.10-linux_x64.tar.gz" ; download_unpack_simple https://cdn.azul.com/zulu/bin/$F bb826d2598b6ceaaae56a6c938f2030e  $F /app/pack/ /app/  