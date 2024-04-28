 #!/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

cd /app/

/app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64  -d exec -D qemu.log    -nographic  -append "console=ttyS0"  -kernel  /app/linux/vmlinux     -initrd /app/linux/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

