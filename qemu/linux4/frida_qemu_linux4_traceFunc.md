
#### 前置
frida监控qemu运行linux4内核 , http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md


#### frida监控qemu运行linux4内核 时，   跟踪xx函数

#####  跟踪 tcg_gen_code 、 tb_gen_code 、 gen_intermediate_code
标签 tag/fridaAnlzAp/qemu__gen_code__linux4__boot_ok

http://giteaz:3000/frida_analyze_app_src/main/src/tag/tag/fridaAnlzAp/qemu__gen_code__linux4__boot_ok



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

