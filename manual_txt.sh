#!/usr/bin/env bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

manual_txt="""使用说明
使用说明正文
1. 步骤1,比如构建,已经执行过了
2. 步骤2,比如运行,已经执行过了
3. 构建过程中所用到的参考文档url为: http://xxx.com/build_doc.md
4. 本项目git仓库地址: https://gitee.com/repok/hello-world.git
"""


# 显示 使用手册文本
echo -e "$manual_txt"
