#!/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   



function LocalDomainSet() {

#若设置本地域名失败，则返回异常（退出代码27）
( source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/local_domain_set.sh) && local_domain_set ;) || return 27


}

#本地域名总是要设置的
LocalDomainSet