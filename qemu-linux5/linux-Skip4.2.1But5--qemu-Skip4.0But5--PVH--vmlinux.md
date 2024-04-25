目标: qemu加载vmlinux

结果：（只验证了qemu-v8.2.2+linux-5.11, 本文所用版本未验证）
    - x86_64的qemu 正常启动 x86_64的启用PVH的vmlinux 
    - i386或x86_x64的qemu 无法启动 i386的启用PVH的vmlinux,  卡在'Booting from ROM...'， 




参考:  
- https://blog.cyyself.name/setup-linux-kernel-debug-environment/  （主要）
- https://stefano-garzarella.github.io/posts/2019-08-23-qemu-linux-kernel-pvh/
- https://superuser.com/questions/1451568/booting-an-uncompressed-vmlinux-kernel-in-qemu-instead-of-bzimage

实现条件: 
- qemu >= 4.0 . 放弃4.0而用5.0, 因为4.0编译总是报错 ```config-temp/qemu-conf.c:2:10: fatal error: qnio/qnio_api.h: No such file or director```
- linux >=4.21, 开启CONFIG_PVH=y  . 找不到4.21, 用其下一个版本5.0,  

##### 编译linux-5.0
linux-4.21找不到，其下一个版本是linux-5.0   

linux-5.0, 2019年3月3日发布， 最佳匹配时刻估计是ubuntu 16.04



1. 编译linux内核步骤


用[~~linux_i386__build.sh~~](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux5/linux_i386__build.sh) 会导致 qemu启动vmlinux 卡在'Booting from ROM...'，,

用[linux_x86_64__build.sh](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux5/linux_x86_64__build.sh)则qemu正常启动


menuconfig时， 尝试手工启用 内核调试、PVM




2. ubuntu 16.04 正常编译 linux-5.0:
```shell
docker pull ubuntu:16.04
docker run --privileged=true --volume /app/qemu/:/app/qemu/  --volume /bal/linux-stable/:/bal/linux-stable/  --name u16 --hostname u16 -itd ubuntu:16.04
docker exec -it u16  bash

```

```shell
apt update
apt install -y build-essential  

#libncurses5-dev被menuconfig需要
apt install -y libncurses5-dev

#flex bison 被linux-5.0需要,  但linux-4.14-y不需要
#解决报错: 找不到 flex
apt install -y flex
#解决报错: 找不到 bison
apt install -y bison

#解决报错: 找不到 ssl/bio.h
apt install -y libssl-dev
#解决报错: 找不到bc
apt install -y bc

#工具
apt install -y git file cpio wget 

gcc --version
# gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609

#0. 编译linux内核步骤

#/bal/linux-stable/
ls -lh  vmlinux
# -rwxr-xr-x   22M  vmlinux

file   vmlinux
# vmlinux: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=6c22a4b562ebb84c9d1055bb9e341363d4844eab, not stripped

ls -lh arch/x86/boot/bzImage 
# -rw-r--r--   7.5M   arch/x86/boot/bzImage

file arch/x86/boot/bzImage 
# arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version 5.0.0 (root@u16) #1 SMP Thu Apr 25 11:06:09 UTC 2024, RO-rootFS, swap_dev 0x7, Normal VGA


```


##### busybox作为initramfs

```shell
echo "10.0.4.9 giteaz westgw" | tee -a /etc/hosts
```

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
#source /app/cmd-wrap/script/env_prepare.sh #已经在frida_anlz_ap:0.1_prv 内执行过了
bash  /app/cmd-wrap/script/cmd_setup.sh
```

qemu编译步骤, [rebuild-v5.0.0--disable-tcg-interpreter--disable-tcg.sh](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/script/rebuild-v5.0.0--disable-tcg-interpreter--disable-tcg.sh)

- ```*-linux-user``` : 用户态模拟，  系统调用转发给物理宿主机操作系统. 因此不支持执行内核
- ```*-softmmu```    ：全系统模拟 



```shell
bash /app/cmd-wrap/script/remove_interceptor.sh
```





##### qemu启动vmlinux

若用x86_64的qemu 并 配合 x86_64的vmlinux, 则qemu正常启动linux内核
```shell
 /app/qemu/build-v8.2.2/x86_64-softmmu/qemu-system-x86_64     -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/vmlinux     -initrd /bal/linux-stable/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

```

若用 i386或x86_x64 的qemu 并 配合 i386的vmlinux ，  ```/app/qemu/build-v5.0.0/i386-softmmu/qemu-system-i386 -kernel  /bal/linux-stable/vmlinux  ```， 则qemu启动linux内核失败并卡住 如下：
```
SeaBIOS (version rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org)
iPXE (http://ipxe.org) 00:02.0 C000 PCI2.10 PnP PMM+07F907B0+07EF07B0 C000
Booting from ROM..  #卡在这里， 实际是 屏幕在不断闪烁
```


##### qemu启动vmlinux 并在qemu视角中通过调试符号看到linux-5.11内核源码中的函数名字

```shell
 /app/qemu/build-v8.2.2/x86_64-softmmu/qemu-system-x86_64  -d exec -D qemu.log    -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/vmlinux     -initrd /bal/linux-stable/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

```

选项d可以是列表 比如 ``` -d exec,int,cpu ```， 帮助请看 ```qemu-system-x86_64  -d --help```


```shell
grep -E  "^Trace .+\] .+$" qemu.log | head -n 5  
# Trace 0: 0x7e5a3817fe40 [0000000000000000/ffffffff810006c0/0xc090] early_setup_idt
# Trace 0: 0x7e5a38180a80 [0000000000000000/ffffffff82d2647a/0xc290] x86_64_start_kernel
# Trace 0: 0x7e5a38180c40 [0000000000000000/ffffffff82d26490/0xc290] x86_64_start_kernel
# Trace 0: 0x7e5a38180ec0 [0000000000000000/ffffffff82d2615a/0xc290] reset_early_page_tables
# Trace 0: 0x7e5a381810c0 [0000000000000000/ffffffff82d26175/0xc290] reset_early_page_tables
```
行末尾的函数名 比如 early_setup_idt, 正是 [qemu.git/v5.0.0/accel/tcg/cpu-exec.c](https://gitee.com/imagg/qemu--qemu/blob/v5.0.0/accel/tcg/cpu-exec.c) 中的cpu_tb_exec 函数中的 ```lookup_symbol(itb->pc)```的取值

```cpp
static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
{
    //...

    qemu_log_mask_and_addr(CPU_LOG_EXEC,  //
    itb->pc,
                           "Trace %d: %p ["
                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
                           cpu->cpu_index, itb->tc.ptr,
                           itb->cs_base, itb->pc, itb->flags,
                           lookup_symbol(itb->pc));
```


 这里期望了很久，也没看到```lookup_symbol(itb->pc)```的取值 [cpu-exec.c/cpu_tb_exec/qemu_log_mask_and_addr](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/qemu_log-exec_int_cpu.md#cpu-execccpu_tb_execqemu_log_mask_and_addr)
