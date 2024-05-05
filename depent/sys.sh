#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
ArgAptGet="-qq   -y" && \
# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
( \
#isRootUsr 是否为root用户
{ isRootUsr=false; [[ $(id --name --user) == root ]] && isRootUsr=true ; true ;} && \
#若不是root用户,有sudo             ; 若是root用户,无sudo
{ { $isRootUsr || SUDO="sudo" ;} ; { $isRootUsr && SUDO="" ;} ; true ;} && \
$SUDO apt-get $ArgAptGet update  1>/dev/null && \
$SUDO apt-get $ArgAptGet install -y  sudo  1>/dev/null && \
sudo apt-get $ArgAptGet install git curl file rsync  1>/dev/null && \
echo "end_of_'sys.sh'" ;) && \
true