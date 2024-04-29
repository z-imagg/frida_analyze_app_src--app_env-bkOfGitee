 #!/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

qemuSysX86F=/app/qemu/build-v8.2.2/x86_64-softmmu/qemu-system-x86_64

#如果已启动，则提示 并 正常退出(退出代码0)
[[ -f $qemuSysX86F ]] && [[ pidof qemu-system-x86_64 ]] && echo "booted! $qemuSysX86F" && exit 0


cd /app/

$qemuSysX86F  -d exec -D qemu.log    -nographic  -append "console=ttyS0"  -kernel  /app/linux/vmlinux     -initrd /app/linux/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

