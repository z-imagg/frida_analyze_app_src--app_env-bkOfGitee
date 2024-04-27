#!/usr/bin/bash

#【描述】  以busybox制作initramfs
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#此脚本任何语句 退出代码不为正常值0 ，都会导致整个脚本退出
set -e

#若设置本地域名失败，则退出代码27
( source  /app/bash-simplify/local_domain_set.sh && local_domain_set ;) || exit 27


Hm=/app/linux/initRamFsHome/
mkdir $Hm && cd $Hm

wget https://www.busybox.net/downloads/binaries/1.16.1/busybox-i686
chmod +x busybox-i686

wget http://giteaz:3000/bal/bal/raw/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/init
chmod +x init

# 执行 cpio_gzip 以 生成 initRamFS
initrdF=$(pwd)/initramfs-busybox-i686.cpio.tar.gz
RT=initramfs && \
( rm -frv $RT &&   mkdir $RT && \
mkdir -pv $RT/{bin,sbin,etc,proc,sys,dev} && \
cp busybox-i686 init $RT/ &&  cd $RT  && \
# 创建 initrd
{ find . | cpio --create --format=newc   | gzip -9 > $initrdF ; }  ) && \
ls -lh $initrdF


# [init](http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/init),
# [eecdc/init](http://giteaz:3000/bal/bal/src/commit/eecdce9efdc46a630119831bec2abbb0263ffe16/bldLinux4RunOnBochs/init)
