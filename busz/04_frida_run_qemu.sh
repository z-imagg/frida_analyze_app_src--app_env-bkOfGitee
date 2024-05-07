#!/usr/bin/bash

#【描述】  frida_js运行应用程序qemu
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


# frida_js运行应用程序qemu
bash -x /fridaAnlzAp/ap-run-anlz/frida_run__qemu_v8.2.2__brch__linux_v5.11.sh