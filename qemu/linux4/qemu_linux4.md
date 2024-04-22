#### linux仓库

https://gitee.com/repok/linux.git

https://gitee.com/repok/linux/tree/linux-4.14.y/  ，  https://gitee.com/repok/linux/commit/050272a0423e68207fd2367831ae610680129062



#### 编译linux4内核、制作启动盘
http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/readme.md

 



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

 