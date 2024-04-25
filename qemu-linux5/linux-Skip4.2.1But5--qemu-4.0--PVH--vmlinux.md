
##### 编译linux-5.0
linux-4.21找不到，其下一个版本是linux-5.0   

linux-5.0, 2019年3月3日发布， 最佳匹配时刻估计是ubuntu 16.04



0. 编译linux内核步骤

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux5/linux_build.sh

menuconfig时，手工启用内核调试

启用内核调试 ，这个参考对吗？   https://www.kerneltravel.net/blog/2021/debug_kernel_szp/


```shell
cd /bal/linux-stable/include/linux/; ls compiler-gcc*
# compiler-gcc.h  compiler-gcc3.h  compiler-gcc4.h
```


3. ubuntu 14.04 正常编译 linux-3.8.3:
```shell
docker pull ubuntu:16.04
docker run --privileged=true --volume /app/qemu/:/app/qemu/  --volume /bal/linux-stable/:/bal/linux-stable/  --name u16 --hostname u16 -itd ubuntu:16.04
docker exec -it u16  bash

```

```shell
apt update
apt install -y build-essential flex bison  libncurses5-dev
#libncurses5-dev被menuconfig需要
#flex bison 被linux-5.0需要,  但linux-4.14-y不需要
 
#解决报错: 找不到 ssl/bio.h
apt install -y libssl-dev
#解决报错: 找不到bc
apt install -y bc

#工具
apt install -y git

gcc --version
# gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609

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
 

##### busybox作为initramfs

```shell
Hm=/bal/linux-stable/initRamFsHome/
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
```
[init](http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/init),
[eecdc/init](http://giteaz:3000/bal/bal/src/commit/eecdce9efdc46a630119831bec2abbb0263ffe16/bldLinux4RunOnBochs/init)




##### ubuntu22下编译qemu-v5.0.0
```shell
docker run --privileged=true --volume /app/qemu/:/app/qemu/    --volume /bal/linux-stable/:/bal/linux-stable/  --name u22  --hostname u22  -it frida_anlz_ap:0.1_prv
#frida_anlz_ap:0.1_prv 是定制的 ubuntu:22.04
#不要-d ，等其执行完
exit
docker start u22
docker exec -it u22  bash

```

```shell
apt-get update 


#安装依赖
apt install -y build-essential python3-venv python3-pip  ninja-build pkg-config libglib2.0-dev
pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple

#  qemu 5.0.0 、 6.2.0  需要的依赖，  qemu v8.2.2 不需要
apt install -y libpixman-1-dev  libpixman-1-0  

#cmd-wrap需要sudo
apt install -y sudo 

```

加cmd-wrap删除```-Wall```以避免以下错误
```
/app/qemu/block/vpc.c:360:51: error: array subscript 'VHDDynDiskHeader {aka struct vhd_dyndisk_header}[0]' is partly outside array bounds of 'uint8_t[512]' {aka 'unsigned char[512]'} [-Werror=array-bounds]
```

```shell
source /app/cmd-wrap/script/env_prepare.sh
bash  /app/cmd-wrap/script/cmd_setup.sh
```

qemu编译步骤, [rebuild-v5.0.0--disable-tcg-interpreter.sh](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/script/rebuild-v5.0.0--disable-tcg-interpreter.sh)

- ```*-linux-user``` : 用户态模拟，  系统调用转发给物理宿主机操作系统. 因此不支持执行内核
- ```*-softmmu```    ：全系统模拟 



```shell
bash /app/cmd-wrap/script/remove_interceptor.sh
```

*softmmu/qemu中竟然没有load_symbols,为何？ 难道是inline了？不像
```shell
readelf --symbols /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386  | grep load_symbols
readelf --symbols /app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64  | grep load_symbols
```
而 disas.c:/lookup_symbol 就是去查询 全局变量 disas.c:/syminfos 的

linux-user/elfload.c:/load_symbols 填充全局变量  disas.c:/syminfos

qemu中竟然没有load_symbols, 因此 全局变量 disas.c:/syminfos 为 空 




linux-user/qemu有load_symbols
```shell
readelf --symbols /app/qemu/build-v5.0.0/i386-linux-user/qemu-i386  | grep load_symbols
#   2750: 00000000001076c0   717 FUNC    LOCAL  DEFAULT   15 load_symbols
```





##### qemu启动linux+busybox

```shell
/app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64 -d exec -D qemu.log  -nographic  -append "console=ttyS0 nokaslr"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/linux-stable/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz
```
依旧找不到bzImage中的调试符号：
[cpu-exec.c/cpu_tb_exec/qemu_log_mask_and_addr](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/qemu_log-exec_int_cpu.md#cpu-execccpu_tb_execqemu_log_mask_and_addr) 中的 ```lookup_symbol(itb->pc)``` 值为 空字符串 即 没找到函数符号 

##### gdb调试 qemu启动linux+busybox

1. qemu启动linux+busybox 后 等待gdb连接
```shell
/app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386 -gdb tcp::1234 -S  -nographic  -append "console=ttyS0 nokaslr"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/linux-stable/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

#等待gdb连接

# /app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386 --help
#-S     freeze CPU at startup (use 'c' to start execution)
```

2. gdb连接 qemu
```shell
cd /bal/linux-stable
gdb vmlinux

# Reading symbols from vmlinux...
# (No debugging symbols found in vmlinux)  #注意这里说没有调试符号，那说明，编译linux时调试符号没加对

```

```shell
show architecture
#The target architecture is set to "auto" (currently "i386").
target remote :1234
# Remote debugging using :1234
break start_kernel
continue
#Breakpoint 1, 0xc1952627 in start_kernel ()
backtrace
#0  0xc1952627 in start_kernel ()
#1  0xc19522a2 in i386_start_kernel ()
#2  0x00000000 in ?? ()

```


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