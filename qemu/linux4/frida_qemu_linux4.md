


 



#### 前置

在这个docker内 编译qemu, http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#build-qemu


http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/env/main_dockerImage_build_run.sh

#### frida监控qemu运行linux4内核


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


```shell
readelf --symbols /app/qemu/build/qemu-system-x86_64 | egrep "main$"
# 37431: 00000000003153f0    23 FUNC    GLOBAL DEFAULT   16 main

bash -x /fridaAnlzAp/main/fridaJs_runApp.sh
```
其.ts中已经写死了如下 目标应用:
```txt
/app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz
``` 


输出日志： ```appOut-*.log``` == ```linux4内核启动输出日志``` + ```frida-out-Mix-*.log```