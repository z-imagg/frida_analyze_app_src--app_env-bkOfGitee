
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

函数cpu_exec不与linux4内核中函数一一对应

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
