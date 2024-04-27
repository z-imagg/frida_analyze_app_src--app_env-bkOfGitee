#!/usr/bin/env bash

#【描述】  使用手册文本
#【依赖】   
#【术语】 
#【备注】   

#定义 docker镜像、实例 的 名称、版本号
source /fridaAnlzAp/app_qemu/app_bld/linux5/docker_instance.sh

manual_txt="""使用说明

来自: http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/main_dockerImage_build_run.sh

1. 进入 docker实例 ${dkInstName} 的bash终端: 
  exit; docker start  $dkInstName ; docker exec -it $dkInstName  /usr/bin/bash

2. 编译linux:
  bash -x /fridaAnlzAp/app_qemu/app_bld/linux5/linux_x86_64__build.sh

3. menuconfig配置人工修改,参考此文注释部分: 
  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/app/qemu/linux5/linux_x86_64__build.sh

4. 以busybox制作initramfs:
  bash -x /fridaAnlzAp/app_qemu/app_bld/linux5/initRamFs_create.sh

5. qemu编译:
  bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/rebuild-v5.0.0--disable-tcg-interpreter--disable-tcg.sh

6. qemu启动vmlinux:
  bash -x /fridaAnlzAp/app_qemu/app_bld/linux5/qemu_boot_vmlinux.sh
"""

