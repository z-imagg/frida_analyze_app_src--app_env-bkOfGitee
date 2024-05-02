 #!/bin/bash

#【描述】  linux-5.11编译步骤
#【依赖】   
#【术语】 
#【备注】   
#【运行环境】 

#本地域名总是要设置的
source /fridaAnlzAp/prj_env/util/LocalDomainSet.sh
#导入_importBSFn.sh
source /fridaAnlzAp/prj_env/util/Load__importBSFn.sh

qemuSysX86F=/app/qemu/build-v8.2.2/x86_64-softmmu/qemu-system-x86_64

#如果已启动，则提示 并 正常退出(退出代码0)
[[ -f $qemuSysX86F ]] && pidof "qemu-system-x86_64" && echo "booted! $qemuSysX86F" && exit 0


#若docker下,写:
cd /gain/
#若宿主机下,写:
# cd /

$qemuSysX86F  -d exec -D qemu.log    -nographic  -append "console=ttyS0"  -kernel  ./app/linux/vmlinux     -initrd ./app/linux/initRamFsHome/initramfs-busybox-i686.cpio.tar.gz

#展示qemu日志中linux4内核vmlinux中的函数符号名
ls -lh  $(pwd)/qemu.log
#qemu源码中cpu-exec.c 的 'lookup_symbol(itb->pc)'  拿到linux4的vmlinux函数符号
#  不为空的
# 删除管道 再 创建管道
rm pipe__sym_ok ; mkfifo pipe__sym_ok
# 写入管道pipe__sym_ok                                      记录写管道的进程id                                 读该管道 从而引发写管道实际发生    等写管道进程执行完
( grep -E  "^Trace .+\] .+$" qemu.log > pipe__sym_ok & ) ; pid__sym_ok=$1; echo "pid__sym_ok=$pid__sym_ok"; head -n 0 pipe__sym_ok;      wait $pid__sym_ok;
# 管道pipe__sym_ok已经持有完整结果,以下是正常业务命令
head -n 5  pipe__sym_ok
wc -l  pipe__sym_ok
#  为空的
# 删除管道 再 创建管道
rm pipe__sym_null ; mkfifo pipe__sym_null
# 写入管道pipe__sym_null                                  记录写管道的进程id                                 读该管道 从而引发写管道实际发生    等写管道进程执行完
( grep  "Trace " qemu.log > pipe__sym_null & ) ; pid__sym_null=$1; echo "pid__sym_null=$pid__sym_null"; head -n 0 pipe__sym_null;      wait $pid__sym_null;
head -n 5  pipe__sym_null
wc -l  pipe__sym_null


#命令管道举例
# mkfifo p1; { ls | head -n 3 > p1 & } ; pid=$!; echo "pid=$pid";  cat p1; wait $pid ; rm p1
#            (                       )  # 上一行{}换成()也是一样效果的