#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e


source /fridaAnlzAp/app_qemu/app_bld/util/git_Clone_SwitchTag.sh
source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/gitproxy.sh)

#以westgw代理执行 git_Clone_SwitchTag
function gitproxy_Clone_SwitchTag() {

#设置git代理westgw
gitproxy_set

#执行git_Clone_SwitchTag, 并记录其退出代码
git_Clone_SwitchTag $* ; local retCode=$?

#不管是否失败,   删除git代理
gitproxy_unset

#返回git_Clone_SwitchTag的退出代码
return $retCode

}