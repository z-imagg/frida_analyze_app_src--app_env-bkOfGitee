#!/usr/bin/env bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】   

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e


#当长久build docker镜像后，需要清理docker占用的磁盘空间
# docker system prune -a

source /fridaAnlzAp/prj_env/env/convert_sh_to_Dockerfile__rmInst__rmImage.sh

#去此脚本所在目录
source /bal/bash-simplify/cdCurScriptDir.sh && cdCurScriptDir


#构建基础镜像 
#  转换 ubuntu1604_linux5build.Dockerfile.sh ---> ubuntu1604_linux5build.Dockerfile  、 删除 、 构建docker镜像
dkInstName="ubuntu1604_linux5build"
dkInstVer="0.1"

msg_tip="""使用说明\n

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

convert_sh_to_Dockerfile__rmInst__rmImage    $dkInstName $dkInstVer  ;  docker build --progress=plain --no-cache  -f "$dkInstName.Dockerfile" -t $dkInstName:$dkInstVer "/" 

# 宿主机是否有linux仓库
hostLnxRpD=/bal/linux-stable
hostHasLnxRp=false ; [[ -f $hostLnxRpD/.git/config ]] && hostHasLnxRp=true
# docker实例中linux仓库路径
dkLnxRpD="/app/linux"
# docker实例的volume映射
volMap=""
# 若 宿主机有linux仓库， 则 docker实例映射该目录
$hostHasLnxRp && volMap="$volMap --volume $hostLnxRpD:$dkLnxRpD"
echo -e "$msg_tip"
# 若初次启动时，则 克隆项目代码 并 退出
docker run -e isDkInstInit='true' $volMap  --name $dkInstName --hostname $dkInstName -it $dkInstName:$dkInstVer
# 退出后， 若docker实例已停止 则 再次启动docker_entry.sh
# docker ps --filter "name=$dkInstName" | grep $dkInstName || { docker start --attach  --interactive $dkInstName    ;}
