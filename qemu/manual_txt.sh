#!/bin/bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/qemu/docker_instance.sh

manual_txt="""使用说明

1. linux5编译
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/main_dockerImage_build_run.sh
  来自:   http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/manual_txt.sh
  详细步骤见链接

2. qemu编译:
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/main_dockerImage_build_run.sh
  来自: http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/manual_txt.sh

2.1. 进入 docker实例 ${dkInstName} 的bash终端: 
  exit #退出此时的docker实例终端
  docker start  $dkInstName ; docker exec -it $dkInstName  /bin/bash

2.2. 编译qemu5.0.0:
  bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/busz/rebuild-qemu-v8.2.2--disable-tcg-interpreter--disable-tcg.sh

3.3. qemu启动vmlinux:
  bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/busz/qemu_boot_vmlinux.sh
"""


# 显示 使用手册文本
echo -e "$manual_txt"