#!/usr/bin/env bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source $pdir/docker_instance.sh

manual_txt="""使用说明

1. linux5编译
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/main_dockerImage_build_run.sh
  来自:   http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/manual_txt.sh

1.1. 进入 docker实例 ${dkInstName} 的bash终端: 
  exit #退出此时的docker实例终端
  docker start  $dkInstName ; docker exec -it $dkInstName  /bin/bash

1.2. 编译linux:
  bash -x $pdir/busz/linux_x86_64__build.sh

1.3. menuconfig配置人工修改,参考此文注释部分: 
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/busz/linux_x86_64__build.sh

1.4. 以busybox制作initramfs:
  bash -x $pdir/busz/initRamFs_create.sh

2. qemu编译:
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/main_dockerImage_build_run.sh
  来自: http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/qemu/manual_txt.sh
  详细步骤见链接

"""


# 显示 使用手册文本
echo -e "$manual_txt"
