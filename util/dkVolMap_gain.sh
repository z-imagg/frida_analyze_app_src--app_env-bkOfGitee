#!/bin/bash

#【描述】  定义 docker产物目录
#【依赖】   
#【术语】  gain == 产物,  dk == docker, Vol == Volume
#【备注】   

set -e

source <(curl --silent http://giteaz:3000/bal/bash-simplify/raw/branch/release/mkMyDirBySudo.sh)

#产物目录 对应宿主机目录
host_gainDir="/gain"
#产物目录 对应docker实例目录
dk_gainDir="/gain"

#产物目录 docker volume映射
dkVolMap_gain="--volume $host_gainDir:$dk_gainDir"

#若宿主机 产物目录 创建
mkMyDirBySudo $host_gainDir

