#!/bin/bash

#【描述】  pre_init 即 init之前执行的脚本
#【依赖】   
#【术语】 pre_init == previous init
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e



function pre_init() {
#返回变量 bash_simplify
bash_simplify="/app/bash-simplify/"
local BS_gitD="$bash_simplify/.git"
local F__importBSFn="$bash_simplify/_importBSFn.sh"

[[ -d $bash_simplify ]] || exit 61
[[ -d $BS_gitD ]] || exit 62
[[ -f $F__importBSFn ]] || exit 63

source $F__importBSFn

}


cd $pdir
pre_init



#此脚本的全部返回变量 bash_simplify 、 _lnNum 、 _func 、 _file 、  pdir