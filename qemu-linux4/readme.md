
TODO： 请排查 [cpu-exec.c/cpu_tb_exec/qemu_log_mask_and_addr](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/qemu_log-exec_int_cpu.md#cpu-execccpu_tb_execqemu_log_mask_and_addr) 中的 ```lookup_symbol(itb->pc)``` 值为 空字符串 即 没找到函数符号 的原因？

```grep "cpu_tb_exec__Trace" qemu.log```
```
...
cpu_tb_exec__Trace 0: 0x7dc7ccbf01c0 [0000000000000000/00000000c30adad0/0x4002b0] 
                ']'后应该有 lookup_symbol(itb->pc) 的值 ，但实际为空串， 即 没找到函数符号 的原因？
...
```

已经尝试 
1. linux内核编译时 加选项```CONFIG_KALLSYMS_ALL=y``` ，貌似不奏效。 为何编译结果bzImage依然只有6.75MB? 既然加了符号信息，不应该大幅度增加体积么？
2. TODO 从qemu入手？

----

编译linux内核， http://giteaz:3000/bal/bal/src/branch/fridaAnlzAp/app/qemu-linux4/bldLinux4RunOnBochs/readme.md


科学上网 克隆git仓库、递归克隆子仓库
```shell
source  /app/wiki/computer/bash_completion/bash_completion-gitproxy.md.sh
#gitproxy <两次tab> 有如下提示，根据需要修改，获得：
git config --global http.proxy socks5://westgw:7890 ; 
git config --global https.proxy socks5://westgw:7890  ; 
git clone -b v5.0.0 --recurse-submodules https://github.com/qemu/qemu.git  ;    
git config --global --unset http.proxy ; 
git config --global --unset https.proxy


```

qemu-v5.0.0 禁止tcg解释器 编译步骤

可选，启用拦截器
```shell
bash -x /app/cmd-wrap/script/cmd_setup.sh
```

```shell
#编译步骤
buildDir="/app/qemu/build-v5.0.0" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --enable-debug-tcg  && \ 
make -j4
# make install
```

可选，移除拦截器
```shell
bash /app/cmd-wrap/script/remove_interceptor.sh
```

qemu运行linux4
```shell
/app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64 -d exec,int,cpu -D qemu.log  -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz

```
```-d exec,int,cpu -D qemu.log``` 用于 qemu显示linux4中函数地址的日志 , http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/qemu_log-exec_int_cpu.md

其他, http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/misc.md