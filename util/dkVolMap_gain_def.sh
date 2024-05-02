#!/bin/bash

#【描述】  定义 docker产物目录
#【依赖】   
#【术语】  gain == 产物,  dk == docker, Vol == Volume, def == define == 定义
#【备注】   

set -e

_importBSFn "mkMyDirBySudo.sh"

#产物目录 对应宿主机目录
gainD_host="/gain"
#产物目录 对应docker实例目录
gainD_dk="/gain"

#产物目录 docker volume映射
dkVolMap_gain="--volume $gainD_host:$gainD_dk"

function mk_gainD_host() {
#若宿主机 产物目录 创建
mkMyDirBySudo $gainD_host
}

