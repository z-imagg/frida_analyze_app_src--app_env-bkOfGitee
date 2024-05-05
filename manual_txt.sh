#!/usr/bin/env bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

manual_txt="""使用说明


linux-v5.11 PVH+调试 的 menuconfig配置人工修改,参考此文注释部分: 
  http://giteaz:3000/frida_analyze_app_src/app_env/src/tag/tag_release__linux_v5.11_build/manual_txt.sh


"""


# 显示 使用手册文本
echo -e "$manual_txt"
