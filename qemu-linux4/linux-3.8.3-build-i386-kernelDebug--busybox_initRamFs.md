
##### 编译linux-3.8.3

基本依赖安装
```shell
apt update
apt-get install -y axel wget curl  net-tools git  iputils-ping build-essential libncurses5-dev
#libncurses5-dev被menuconfig需要
```

0. 编译linux内核步骤
```shell
make mrproper && \
make clean && \
make ARCH=i386 CC=gcc defconfig && \
make ARCH=i386 CC=gcc menuconfig && \
make ARCH=i386 CC=gcc -j 6  V=1
```
menuconfig时，手工启用内核调试

启用内核调试 ，这个参考对吗？   https://www.kerneltravel.net/blog/2021/debug_kernel_szp/


```shell
cd /bal/linux-stable/include/linux/; ls compiler-gcc*
# compiler-gcc.h  compiler-gcc3.h  compiler-gcc4.h
```


3. ubuntu 14.04 正常编译 linux-3.8.3:
```shell
docker pull ubuntu:14.04
docker run --privileged=true --volume /bal/linux-stable/:/bal/linux-stable/  --name u14 --hostname u14 -itd ubuntu:14.04
docker exec -it u14  bash

gcc --version
# gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4

#0. 编译linux内核步骤

#/bal/linux-stable/
ls -lh  vmlinux
# -rwxr-xr-x   15M   vmlinux
file   vmlinux
# vmlinux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=175d32c27dddf299ef711c291a7dd0e8c9626832, not stripped


ls -lh arch/x86/boot/bzImage 
# -rw-r--r--  5.1M   arch/x86/boot/bzImage
file arch/x86/boot/bzImage 
# arch/x86/boot/bzImage: x86 boot sector

```
注意:

linux-4.14-y编译后,  任何地方都没有文件vmlinux  

但linux-3.8.3编译后， 在源码根目录```/bal/linux-stable/```有elf文件vmlinux


```shell
function dk_cp_u14_to_u22() {
local tmpF=/tmp/$F
docker cp u14:$F $tmpF
docker cp $tmpF frida_anlz_ap:$F
#frida_anlz_ap是ubuntu22.04
}

dk_cp_u14_to_u22 /bal/linux-stable/arch/x86/boot/bzImage
dk_cp_u14_to_u22 /bal/linux-stable/vmlinux

```

##### busybox作为initramfs

```shell
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
{ find . | cpio --create --format=newc   | gzip -9 > $initrdF ; }  )
```
[init](http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/init),
[eecdc/init](http://giteaz:3000/bal/bal/src/commit/eecdce9efdc46a630119831bec2abbb0263ffe16/bldLinux4RunOnBochs/init)

##### 失败记录


ubuntu版本历史 ，  https://en.wikipedia.org/wiki/Ubuntu_version_history

1. ubuntu 22.04编译linux-3.8.3报错:
```shell
#0. 编译linux内核步骤

#include/linux/compiler-gcc.h:100:1: fatal error: linux/compiler-gcc11.h: No such file or directory
```



2. ubuntu 16.04编译linux-3.8.3报错:
```shell
docker pull ubuntu:16.04
docker run --privileged=true --volume /bal/linux-stable/:/bal/linux-stable/  --name u16 --hostname u16 -itd ubuntu:16.04
docker exec -it u14  bash


#0. 编译linux内核步骤
#include/linux/compiler-gcc.h:100:30: fatal error: linux/compiler-gcc5.h: No such file or directory



```