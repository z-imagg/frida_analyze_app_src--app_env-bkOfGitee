#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
ArgAptGet="-qq   -y" && \
( set -x && \
SUDO="sudo" ; { [[ $(id --name --user) == root ]] && SUDO="" ;} && \
$SUDO apt-get $ArgAptGet update  1>/dev/null && \
$SUDO apt-get $ArgAptGet install -y  sudo  1>/dev/null && \
sudo apt-get $ArgAptGet install -y axel wget curl  net-tools git  iputils-ping cpio python3 python3-urllib3  1>/dev/null  ;) && \
true