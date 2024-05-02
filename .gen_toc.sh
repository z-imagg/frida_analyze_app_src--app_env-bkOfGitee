#!/bin/bash

#进入目录 当前目录, 变量pdir为当前目录绝对路径
source ./pre_init.sh || exit 70

source $bash_simplify/gen_toc.sh
# 【用法举例】 gen_tableOfContent  /app/wiki/ http://giteaz:3000/wiki/wiki/src/branch/main /app/wiki/readme.md

gen_tableOfContent  $pdir/ http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main $pdir/readme.md 
