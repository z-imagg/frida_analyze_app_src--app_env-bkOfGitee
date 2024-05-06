#!/usr/bin/bash

#【描述】  miniconda3  安装、激活
#【依赖】   
#【术语】 
#【备注】  

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#导入配置
source $pdir/docker_instance.sh

#miniconda3
{ [[ -f /app/Miniconda3-py310_22.11.1-1/bin/python ]] || bash  /app/pack/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh -b -p /app/Miniconda3-py310_22.11.1-1/ ;} && \
source /app/Miniconda3-py310_22.11.1-1/bin/activate && which python &&  \
true