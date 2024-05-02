#!/bin/bash

#【描述】  导入_importBSFn.sh
#【依赖】   
#【术语】 
#【备注】   


function Load__importBSFn() {

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/tag/tag_release/_importBSFn.sh)

}

#本地域名总是要设置的
Load__importBSFn