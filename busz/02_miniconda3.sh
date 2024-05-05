#!/usr/bin/bash

#【描述】  miniconda3  安装、激活
#【依赖】   
#【术语】 
#【备注】  

#公共依赖
source /fridaAnlzAp/prj_env/env/common_all.sh && \
#miniconda3
{ [[ -f /app/Miniconda3-py310_22.11.1-1/bin/python ]] || bash  /app/pack/Miniconda3-py310_22.11.1-1-Linux-x86_64.sh -b -p /app/Miniconda3-py310_22.11.1-1/ ;} && \
source /app/Miniconda3-py310_22.11.1-1/bin/activate && which python &&  \
true