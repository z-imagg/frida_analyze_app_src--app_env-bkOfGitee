#!/bin/bash

#【描述】  基本导入: 域名设置、_importBSFn
#【依赖】   
#【术语】 
#【备注】   

#本地域名总是要设置的
source $pdir/util/LocalDomainSet.sh
#导入_importBSFn.sh
source /app/bash-simplify/_importBSFn.sh
_importBSFn "git_Clone_SwitchTag.sh"
