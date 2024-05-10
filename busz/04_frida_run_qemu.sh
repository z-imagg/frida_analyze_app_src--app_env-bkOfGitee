#!/usr/bin/bash

#【描述】  ap-run-anlz入口脚本
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


# ap-run-anlz入口脚本
bash -x /fridaAnlzAp/ap-run-anlz/prj_main.sh