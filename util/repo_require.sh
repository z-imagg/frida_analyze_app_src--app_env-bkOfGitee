#!/bin/bash

#【描述】  基本需求: 域名设置、_importBSFn、克隆基本仓库
#【依赖】   
#【术语】 
#【备注】   

#基本导入: 域名设置、_importBSFn 、 docker_instance.sh 、 isInDocker
source $pdir/docker_instance.sh

#  删除 构建Dockerfile时 用的目录  
$inDocker && ( mv /app/app_env /app/tmp_app_env ;  \
mv /app/bash-simplify /app/tmp_bash-simplify ;)

#克隆仓库app_env版本 tag_release__*
git_Clone_SwitchTag "http://giteaz:3000/frida_analyze_app_src/app_env.git"  "${app_env__tag}"  "/app/app_env"
#克隆仓库cmd-wrap版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/bal/cmd-wrap.git"  "tag_release"  "/app/cmd-wrap"
#克隆仓库bash-simplify版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/bal/bash-simplify.git"  "tag_release"  "/app/bash-simplify"