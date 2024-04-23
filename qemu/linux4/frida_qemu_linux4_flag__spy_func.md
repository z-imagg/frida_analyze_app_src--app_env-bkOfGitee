
#### linux仓库

https://gitee.com/repok/linux.git



https://gitee.com/repok/linux/tree/linux-4.14.y--flag__spy_func/  ， https://gitee.com/repok/linux/commit/072fcdb7a3f54436f2922baf577040fe927b237a

#### qemu仓库


https://gitee.com/imagg/qemu--qemu/tree/qemu-v8.2.2-merge-03/  ,  https://gitee.com/imagg/qemu--qemu/commit/d18d37e3d8e9590617d0008625a390c5f5b31f83
 



#### 前置
frida监控qemu运行linux4内核 , http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md


#### frida监控qemu运行linux4内核 ，linux4源码中新加入特定标记参数值的函数调用， frida由该参数值找到函数地址 与 System.map 中地址比对 获得 qemu 对 linux4函数地址 变换规律

** frida监控qemu运行linux4内核 时，  linux4内核中已经添加入参0为特定标记值0x44BB55CC的函数flag__spy_func调用， 为了方便frida通过标记参数识别到此函数 **

##### 1.build-qemu
[add_interceptor](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#add_interceptor),
[build-qemu-step](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#build-qemu-step),
[remove_interceptor](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#remove_interceptor)

或简写为
```shell
bash -x /app/cmd-wrap/script/cmd_setup.sh   ;   bash  /app/qemu/rebuild.sh &&  bash /app/cmd-wrap/script/remove_interceptor.sh
```
##### 2.build-linux4
```shell

bash -x /bal/bldLinux4RunOnBochs/build-linux4.15.y-on-x64_u22.04.3LTS.sh

grep flag__spy_func /bal/linux-stable/System.map 
# c1b5042c T flag__spy_func


```


[copy_linux4_kernel_to_docker](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md#copy_linux4_kernel_to_docker)
##### 3. qemu_linux
```shell
bash  /app/qemu/run_linux4_kernel.sh   2>&1 | tee qemu_linux4.log
```


qemu中给ffi_call调用编号,应用linux4内核中标记函数,多次运行以收紧,gdb日志中靠近标记函数的调用编号可进标记函数调用链内  【间隔为1, 放到ffi_call前, fflush】,  https://gitee.com/imagg/qemu--qemu/commit/xxx

```shell
grep -Hn "at_" qemu_linux4.log   | grep  -A 1 -B 1  "flag__spy_func.at_linux_src_code"
# qemu_linux4.log:4457:##threadId=140737333511744,_wrap_ffi_call___callIdx.at_qemu_src_code=4432
# qemu_linux4.log:4458:[    0.000000] flag__spy_func.at_linux_src_code==0xc795042c
# qemu_linux4.log:4546:##threadId=140737333511744,_wrap_ffi_call___callIdx.at_qemu_src_code=4433

```


```shell
alias GDB_qemu_linux4='gdb   --quiet  --command=gdb_script.txt --args /app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz'


```



```shell
#gdb 以4432~4432+1000 再c 500 发现了4456后立即输出 'flag__spy_func.at_linux_src_code==0xc5d5042c'

clear

cat  << 'EOF' > gdb_script.txt
break _wrap_ffi_call___callIdx__inc if (int)_wrap_ffi_call___callIdx>=4456 && (int)_wrap_ffi_call___callIdx<=4459+1000
commands 1
  printf "_wrap_ffi_call___callIdx=%d\n",(int)_wrap_ffi_call___callIdx
  frame 2
  print func
end

run

EOF

GDB_qemu_linux4

#frame 2停止在:
# 2  0x0000555555e434d2 in tcg_qemu_tb_exec () at ../tcg/tci.c:455

```

```shell
#gdb条件举例
# break _wrap_ffi_call___callIdx__inc if (int)_wrap_ffi_call___callIdx>=4447 && (int)_wrap_ffi_call___callIdx<=4448


```

工具函数

```shell
function gdb_loop_find() {
    
clear

alias GDB_qemu_linux4='gdb   --quiet  --command=gdb_script.txt --args /app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz'




cat  << 'EOF' > gdb_script.txt.template
break _wrap_ffi_call___callIdx__inc if (int)_wrap_ffi_call___callIdx==guess_i
commands 1
  printf "_wrap_ffi_call___callIdx=%d\n",(int)_wrap_ffi_call___callIdx
  frame 2
  print func
end

run

EOF

for k in $(seq 4000 5000); do
    sed  "s/guess_i/$k/g" gdb_script.txt.template > gdb_script.txt
    GDB_qemu_linux4  2>&1 | tee qemu_linux4.log
    grep "flag__spy_func.at_linux_src_code" qemu_linux4.log && { echo "k=$k" ; break ;}
done



}

```

##### 4.frida_qemu_linux4
[frida_qemu_linux4](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md#frida_qemu_linux4)

[watch_appOut-X.log](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4_ignoreHugeFunc.md#watch_appout-xlog)