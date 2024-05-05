#!/bin/bash

#【描述】  以busybox制作initramfs
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e -u

#导入配置
source $pdir/docker_instance.sh

_importBSFn "cpFPathToDir.sh"
# 引入全局变量 gainD_dk
source $pdir/util/dkVolMap_gain_def.sh

Hm=$prjGRpD/initRamFsHome/
initrdF=${Hm}/initramfs-busybox-i686.cpio.tar.gz

function print_initrdF() {
echo "展示initrdF"
ls -lh $initrdF
}

#如果已有编译产物，则显示产物 并 正常退出(退出代码0)
[[ -f $initrdF ]] && print_initrdF && exit 0

#正文开始
mkdir $Hm && cd $Hm

wget https://www.busybox.net/downloads/binaries/1.16.1/busybox-i686
chmod +x busybox-i686

wget http://giteaz:3000/bal/bal/raw/tag/tag__fridaAnlzAp_app_qemu-linux4/bldLinux4RunOnBochs/init
chmod +x init

# 执行 cpio_gzip 以 生成 initRamFS
RT=initramfs && \
( rm -frv $RT &&   mkdir $RT && \
mkdir -pv $RT/{bin,sbin,etc,proc,sys,dev} && \
cp busybox-i686 init $RT/ &&  cd $RT  && \
# 创建 initrd
{ find . | cpio --create --format=newc   | gzip -9 > $initrdF ; }  ) && \
# 收集产物
cpFPathToDir  $initrdF $gainD_dk/ && \
print_initrdF


# [init](http://giteaz:3000/bal/bal/raw/tag/tag__fridaAnlzAp_app_qemu-linux4/bldLinux4RunOnBochs/init),
# [eecdc/init](http://giteaz:3000/bal/bal/src/commit/eecdce9efdc46a630119831bec2abbb0263ffe16/bldLinux4RunOnBochs/init)
