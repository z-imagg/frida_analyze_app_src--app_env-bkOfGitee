#!/usr/bin/bash

#【描述】  qemu v8.2.2 运行时依赖,  编译产物qemu-system-x86_x64运行需要的依赖
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u


#qemu v8.2.2 运行时依赖,  编译产物qemu-system-x86_x64运行需要的依赖
curl http://giteaz:3000/frida_analyze_app_src/app_env/raw/tag/tag_release__qemu_v8.2.2_build/depent/___sys_thin.sh | bash