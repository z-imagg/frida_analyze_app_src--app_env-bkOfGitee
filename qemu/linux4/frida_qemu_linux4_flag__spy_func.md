
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

```shell

grep -Hn "flag__spy_func.at_linux_src_code" qemu_linux4.log
# qemu_linux4.log:44:[    0.000000] flag__spy_func.at_linux_src_code==0xc575042c
```

qemu中给ffi_call调用编号,应用linux4内核中标记函数,多次运行以收紧,gdb日志中靠近标记函数的调用编号可进标记函数调用链内 【收紧2】间隔为10,  https://gitee.com/imagg/qemu--qemu/commit/5a198d086a200b38a6ed46170f62f779600968c2
```shell
grep -Hn "at_" qemu_linux4.log   | grep  -A 1 -B 1  "flag__spy_func.at_linux_src_code"
# qemu_linux4.log:43:##threadId=140737333511744,_wrap_ffi_call___callIdx.at_qemu_src_code=4390
# qemu_linux4.log:44:[    0.000000] flag__spy_func.at_linux_src_code==0xc575042c
# qemu_linux4.log:143:##threadId=140737333511744,_wrap_ffi_call___callIdx.at_qemu_src_code=4400
```

qemu中给ffi_call调用编号,应用linux4内核中标记函数,多次运行以收紧,gdb日志中靠近标记函数的调用编号可进标记函数调用链内 【收紧3】间隔为1,  https://gitee.com/imagg/qemu--qemu/commit/d3a9fdebb51ccd87f6763cb3651d322708b3c18e
```shell
grep -Hn "at_" qemu_linux4.log   | grep  -A 1 -B 1  "flag__spy_func.at_linux_src_code"
# qemu_linux4.log:34:##threadId=140737333511744,_wrap_ffi_call___callIdx.at_qemu_src_code=4400
# qemu_linux4.log:35:[    0.000000] flag__spy_func.at_linux_src_code==0xc715042c

```

```shell
alias GDB_qemu_linux4='gdb --batch  --quiet  --command=gdb_script.txt --args /app/qemu/build-v8.2.2/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz'


#增加以下条件断点
# break _wrap_ffi_call___callIdx__inc if (int)_wfCallIdx==4400

```
可能是因为 qemu日志输出 或 linux4 日志输出有缓存， 导致日志先后并不能反应代码执行先后， 以上条件已经错了过 linux4中的标记函数

```shell
#只好更换大范围gdb断点
# break _wrap_ffi_call___callIdx__inc if (int)_wfCallIdx>=4000 || (int)_wfCallIdx<=4400

```

```shell
#不在范围 4200~4300
cat  << 'EOF' > gdb_script.txt
break _wrap_ffi_call___callIdx__inc if (int)_wfCallIdx>=4290 && (int)_wfCallIdx<=4300
commands 1
  printf "_wfCallIdx=%d\n",(int)_wfCallIdx
  exit
end

run

EOF

GDB_qemu_linux4

```

##### 4.frida_qemu_linux4
[frida_qemu_linux4](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md#frida_qemu_linux4)

[watch_appOut-X.log](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4_ignoreHugeFunc.md#watch_appout-xlog)