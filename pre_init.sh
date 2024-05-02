#!/bin/bash

#【描述】  pre_init 即 init之前执行的脚本
#【依赖】   
#【术语】 pre_init == previous init
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

function pre_init() {

local BS_hm="/app/bash-simplify/"
local BS_gitD="BS_hm/.git"
local F__importBSFn="/app/bash-simplify/_importBSFn.sh"
local F_parseCallerN="/app/bash-simplify/parseCallerN.sh"

[[ -d $BS_hm ]] || exit 61
[[ -d $BS_gitD ]] || exit 62
[[ -f $F__importBSFn ]] || exit 63
[[ -f $F_parseCallerN ]] || exit 64

#返回变量 _lnNum 、 _func 、 _file
parseCallerN 0 || exit 65
}

pre_init

pdir=$(dirname $_file)
cd $pdir
