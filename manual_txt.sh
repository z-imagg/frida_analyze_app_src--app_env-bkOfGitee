#!/usr/bin/env bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

manual_txt="""使用说明
使用说明正文
1. xxx
2. yyy
"""


# 显示 使用手册文本
echo -e "$manual_txt"
