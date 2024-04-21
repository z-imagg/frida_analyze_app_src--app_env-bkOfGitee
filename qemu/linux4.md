
```base_ubuntu_22.04.04:0.1 ``` 来自 http://giteaz:3000/frida_analyze_app_src/main/src/branch/fridaAnlzAp/docker/docker/main_dockerImage_build_run.sh

```shell
docker run -v /bal/:/bal/ -v /app/:/app/ --privileged=true  --name u22  -itd base_ubuntu_22.04.04:0.1 
docker exec -it u22 bash
```


#### 编译linux4内核、制作启动盘
http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/readme.md

 
#### qemu下的linux4终端 人工正常关机 

```shell
/busybox-i686 ls /proc
#正常显示了各种进程id目录

/busybox-i686 ps auxf
#正常显示进程列表
```

```shell
/busybox-i686 poweroff -f 
#正常关机了
```



#### qemu下的linux4  脚本正常关机 

脚本关机 ```cat /bal/bldLinux4RunOnBochs/init``` : 
```shell
#!/busybox-i686 ash
/busybox-i686 mount -t proc none /proc
/busybox-i686 mount -t sysfs none /sys
exec /busybox-i686 ash -c "/busybox-i686 ls /proc ; /busybox-i686 ps auxf; /busybox-i686 ls /; /busybox-i686 poweroff -f;"
```



#### qemu运行linux

#####  自编译的qemu-system-x86_64 8.2.2 正常启动字符界面

```shell
/app/qemu/build-v8.2.2/qemu-system-x86_64 --version
#QEMU emulator version 8.2.2 (v8.2.2)


# 末尾加 '  -monitor stdio ' 可获得qemu控制台
/app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"   /bal/bldLinux4RunOnBochs/HD50MB200C16H32S.img
#字符界面，正常启动到linux终端

/app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz 
#字符界面，正常启动到linux终端

```

 


#### frida监控qemu运行linux4内核


http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/env/main_dockerImage_build_run.sh
```shell
# docker run --privileged=true      --name   frida_anlz_ap  --hostname faa_dk --interactive --tty   frida_anlz_ap:0.1_prv
# exit

function docker_mkdir_cp() {
docker exec frida_anlz_ap  bash -c  "mkdir -p $(dirname $F)"
docker cp $F  frida_anlz_ap:$F
}
F=/bal/linux-stable/arch/x86/boot/bzImage docker_mkdir_cp


F=/bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz docker_mkdir_cp


F=/bal/bldLinux4RunOnBochs/HD50MB200C16H32S.img docker_mkdir_cp



docker start frida_anlz_ap
docker exec -it frida_anlz_ap  bash
```
在这个docker内 编译qemu, http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#build-qemu


```shell
readelf --symbols /app/qemu/build/qemu-system-x86_64 | egrep "main$"
# 37431: 00000000003153f0    23 FUNC    GLOBAL DEFAULT   16 main

```



#### frida监控qemu运行linux4内核 时，  frida跳过linux4内核中某些巨量函数调用

按照标签: 
     http://giteaz:3000/frida_analyze_app_src/main/src/tag/tag/fridaAnlzAp/qemu__linux4__boot_ok3  
     https://gitee.com/imagg/qemu--qemu/tree/tag/fridaAnlzAp/qemu__linux4__boot_ok3

所用代码指纹如下
```shell
git --git-dir=/app/qemu/.git rev-parse HEAD
# 2e51efb4cadfac5dcdd371ec345292abe98240fe

git --git-dir=/fridaAnlzAp/main/.git rev-parse HEAD
# ee9dfe953ac4f8a97ffacc360fd228b5d9b2b892


md5sum /app/qemu/build-v8.2.2/qemu-system-x86_64
# c21e373d11757d342f716d19ed9c02cf  /app/qemu/build-v8.2.2/qemu-system-x86_64

```

先运行一次 ```fridaJs_runApp.sh```获得日志文件```appOut-1713713504.log```，统计linux4内核中函数调用次数，巨量次数的函数地址如下：
    注意 估计 重新编译qemu后， 这些函数地址 会不一样 
```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713713504.log  | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
# 728396 555555b5d0e0
# 75774 555555b14c90
# 48476 555555b5e090
# 37826 555555b13e90
# 28562 555555b5e080
# 24906 555555b7a150
# 21084 555555b13ec0
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713714349.log   | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#  436570 555555b74000
#  436366 555555b7c920
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715134.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#  104280 555555b5e2c0
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715453.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#   76881 555555b73310
#   17922 555555b13fb0
#   17646 555555b14000
#后面没列出来的都是不足1万次
```

排除巨量次数函数，如下：
```shell
cat  << 'EOF' > /tmp/FrdaIgnFnLs.txt
0x555555c4bcc0
0x555555b5de80
0x555555b5d0e0
0x555555b14c90
0x555555b5e090
0x555555b13e90
0x555555b5e080
0x555555b7a150
0x555555b13ec0
0x555555b74000
0x555555b7c920
0x555555b5e2c0
0x555555b73310
0x555555b13fb0
0x555555b14000
EOF
```

再次执行```fridaJs_runApp.sh```，  日志会小很多, 居然就大约10分钟不到，就跑完了
```shell


wc -l  /fridaAnlzAp/frida_js/*.log 
#    37739 /fridaAnlzAp/frida_js/appOut-1713715689.log
#    37340 /fridaAnlzAp/frida_js/frida-out-Mix-1713715689.log
#    18667 /fridaAnlzAp/frida_js/frida-out-PrefixPure-1713715689.log
#    18667 /fridaAnlzAp/frida_js/frida-out-Pure-1713715689.log

grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715689.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#    4866 555555b740f0
#    2724 555555b13f50
#    2250 555555b7c690
#    1936 555555b13f80
#    1780 555555b13ef0
#    1306 555555b13f20
#    1072 555555b73350
#     740 555555b73f60
#     664 555555b7a590
#     662 555555b65790
#     204 555555b14760
#     148 555555b142a0
#      74 555555b735a0
#      38 555555b653b0
#      26 555555b61200
#      22 555555b658b0
#      22 555555b611f0
#      22 555555b5ffa0
#      22 555555b11da0
#      12 555555b61240
#      12 555555b13c90
#      10 555555b7add0
#       6 555555b79b50
#       5 555555b14ca0
#       4 555555b7cae0
#       4 555555b7b010
#       4 555555b79df0
#       4 555555b73250
#       4 555555b61140
#       4 555555b61120
#       4 555555b60520
#       4 555555b5ff20
#       4 555555b5fe20
#       2 555555b60d50
#       2 555555b60ac0
#       2 555555b60970
#       2 555555b601e0

```







#### frida监控qemu运行linux4内核 时，   跟踪xx函数

#####  跟踪 tcg_gen_code 、 tb_gen_code 、 gen_intermediate_code
标签 tag/fridaAnlzAp/qemu__gen_code__linux4__boot_ok

http://giteaz:3000/frida_analyze_app_src/main/src/tag/tag/fridaAnlzAp/qemu__gen_code__linux4__boot_ok


http://giteaz:3000/frida_analyze_app_src/frida_js/src/tag/tag/fridaAnlzAp/qemu__gen_code__linux4__boot_ok/fridaJs_runApp.sh

```bash -x /fridaAnlzAp/frida_js/fridaJs_runApp.sh```
其.ts中已经写死了如下 目标应用:
```txt
/app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz
``` 

输出日志： ```appOut-*.log``` == ```linux4内核启动输出日志``` + ```frida-out-Mix-*.log```
```shell


grep "Early table checksum verification disabled"      /fridaAnlzAp/frida_js/frida-out-Mix-1713584459.log  /fridaAnlzAp/frida_js/appOut-1713584459.log 
# /fridaAnlzAp/frida_js/appOut-1713584459.log:[    0.000000] ACPI: Early table checksum verification disabled

wc -l       /fridaAnlzAp/frida_js/frida-out-Mix-1713584459.log  /fridaAnlzAp/frida_js/appOut-1713584459.log 
#    817137 /fridaAnlzAp/frida_js/frida-out-Mix-1713584459.log
#    817557 /fridaAnlzAp/frida_js/appOut-1713584459.log

```
```appOut-*.log``` 比 ```frida-out-Mix-*.log``` 多出的日志行数为```817557-817137==420```行， 即  ```linux4内核启动输出日志``` 为420行日志



```shell
mv /fridaAnlzAp/frida_js/*log* ~/log_qemu__gen_code/
ls -l  ~/log_qemu__gen_code/
#-rw-r--r-- 1 root root 127599400 Apr 20 03:47 appOut-1713584459.log
#-rw-r--r-- 1 root root 127573526 Apr 20 03:47 frida-out-Mix-1713584459.log
#-rw-r--r-- 1 root root        63 Apr 20 03:47 frida-out-Mix-1713584459.log.md5sum.txt
#-rw-r--r-- 1 root root 127163736 Apr 20 03:47 frida-out-PrefixPure-1713584459.log
#-rw-r--r-- 1 root root        70 Apr 20 03:47 frida-out-PrefixPure-1713584459.log.md5sum.txt
#-rw-r--r-- 1 root root 124712352 Apr 20 03:47 frida-out-Pure-1713584459.log
#-rw-r--r-- 1 root root        64 Apr 20 03:47 frida-out-Pure-1713584459.log.md5sum.txt

ls -lh  ~/log_qemu__gen_code/
#-rw-r--r-- 1 root root 122M Apr 20 03:47 appOut-1713584459.log
#-rw-r--r-- 1 root root 122M Apr 20 03:47 frida-out-Mix-1713584459.log
#-rw-r--r-- 1 root root   63 Apr 20 03:47 frida-out-Mix-1713584459.log.md5sum.txt
#-rw-r--r-- 1 root root 122M Apr 20 03:47 frida-out-PrefixPure-1713584459.log
#-rw-r--r-- 1 root root   70 Apr 20 03:47 frida-out-PrefixPure-1713584459.log.md5sum.txt
#-rw-r--r-- 1 root root 119M Apr 20 03:47 frida-out-Pure-1713584459.log
#-rw-r--r-- 1 root root   64 Apr 20 03:47 frida-out-Pure-1713584459.log.md5sum.txt

```



#####  跟踪 cpu_exec

结论：  函数cpu_exec不与linux4内核中函数一一对应

```shell
mv /fridaAnlzAp/frida_js/*log* ~/log_qemu__cpu_exec/

appLogF=~/log_qemu__cpu_exec/appOut-1713585924.log
fridaLogF=~/log_qemu__cpu_exec/frida-out-Mix-1713585924.log
wc -l     $fridaLogF  $fridaLogF
#   95581 /root/log_qemu__cpu_exec/frida-out-Mix-1713585924.log
#   95981 /root/log_qemu__cpu_exec/appOut-1713585924.log

linux4KernelLogLnCnt=$(( $( cat $appLogF | wc -l  ) - $( cat      $fridaLogF   | wc -l )   ))

echo "linux4内核输出日志行数==${linux4KernelLogLnCnt}"
```
linux4内核输出日志行数==400

```shell
ls -l  ~/log_qemu__cpu_exec/
#-rw-r--r-- 1 root root 15130720 Apr 20 04:07 appOut-1713585924.log
#-rw-r--r-- 1 root root 15105006 Apr 20 04:07 frida-out-Mix-1713585924.log
#-rw-r--r-- 1 root root       63 Apr 20 04:07 frida-out-Mix-1713585924.log.md5sum.txt
#-rw-r--r-- 1 root root 15056584 Apr 20 04:07 frida-out-PrefixPure-1713585924.log
#-rw-r--r-- 1 root root       70 Apr 20 04:07 frida-out-PrefixPure-1713585924.log.md5sum.txt
#-rw-r--r-- 1 root root 14769856 Apr 20 04:07 frida-out-Pure-1713585924.log
#-rw-r--r-- 1 root root       64 Apr 20 04:07 frida-out-Pure-1713585924.log.md5sum.txt

ls -lh  ~/log_qemu__cpu_exec/
#-rw-r--r-- 1 root root 15M Apr 20 04:07 appOut-1713585924.log
#-rw-r--r-- 1 root root 15M Apr 20 04:07 frida-out-Mix-1713585924.log
#-rw-r--r-- 1 root root  63 Apr 20 04:07 frida-out-Mix-1713585924.log.md5sum.txt
#-rw-r--r-- 1 root root 15M Apr 20 04:07 frida-out-PrefixPure-1713585924.log
#-rw-r--r-- 1 root root  70 Apr 20 04:07 frida-out-PrefixPure-1713585924.log.md5sum.txt
#-rw-r--r-- 1 root root 15M Apr 20 04:07 frida-out-Pure-1713585924.log
#-rw-r--r-- 1 root root  64 Apr 20 04:07 frida-out-Pure-1713585924.log.md5sum.txt

```

```shell
wc -l  ~/log_qemu__cpu_exec/frida-out-*.log                
#   95581 /root/log_qemu__cpu_exec/frida-out-Mix-1713585924.log
#   47788 /root/log_qemu__cpu_exec/frida-out-PrefixPure-1713585924.log
#   47788 /root/log_qemu__cpu_exec/frida-out-Pure-1713585924.log
```
qemu中的函数cpu_exec在linux4内核启动、关机过程中 执行了 47788/2 == 23894 次，  才2万多次，  说明 函数cpu_exec不与linux4内核中函数一一对应


人工观看 函数 cpu_exec 所在源文件```/app/qemu/accel/tcg/cpu-exec.c```, 发现新目标 : 
```cpu_exec_loop```   , ```tb_lookup```, ```cpu_loop_exec_tb```

```shell
readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | grep cpu_exec_loop
# 22995: 00000000006f6710  2678 FUNC    LOCAL  DEFAULT   16 cpu_exec_loop

readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | egrep "tb_lookup$"
# 22986: 00000000006f6070   219 FUNC    LOCAL  DEFAULT   16 tb_lookup
# 54140: 00000000008d46b0   154 FUNC    GLOBAL DEFAULT   16 tcg_tb_lookup
```

```shell
readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | grep "cpu_loop_exec_tb"
#elf的调试符号表中无该符号
```
函数cpu_loop_exec_tb是内联的，因此elf的调试符号表中没有其


https://gitee.com/imagg/qemu--qemu/blob/v8.2.2/accel/tcg/cpu-exec.c

```cpp
// file : /app/qemu/accel/tcg/cpu-exec.c

static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                    vaddr pc, TranslationBlock **last_tb,
                                    int *tb_exit)
{
```


##### 跟踪 cpu_loop_exec_tb

 编译qemu的分支 ```fridaAnlzAp/app/qemu/v8.2.2```,  
 
 请复制   http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#build-qemu

修改如下：

```shell

#开头增加一行
rm -fr /app/qemu

#git clone -b v8.2.2  ...  #改为
git clone -b fridaAnlzAp/app/qemu/v8.2.2   https://gitee.com/imagg/qemu--qemu.git /app/qemu

#末尾增加一行
ln -s /app/qemu/build-v8.2.2 /app/qemu/build-v8.2.2-modify


```


```shell
wc -l      /fridaAnlzAp/frida_js/appOut-1713591230.log
#7804757 /fridaAnlzAp/frida_js/appOut-1713591230.log

ls -lh       /fridaAnlzAp/frida_js/appOut-1713591230.log  
#-rw-r--r-- 1 root root 1.3G Apr 20 06:18 /fridaAnlzAp/frida_js/appOut-1713591230.log

```

感觉 cpu_loop_exec_tb 跟踪的 是 每一条指令， 日志行数目到了 780万行 还没运行结束

