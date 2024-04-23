

####  qemu源码中的 tcg_qemu_tb_exec

-【术语】 tcg_qemu_tb_exec为函数而非指针 == 允许 CONFIG_TCG_INTERPRETER 

默认情况下 编译开关 tcg_qemu_tb_exec为指针而非函数 


##### 如何 修改 ？ 使得   tcg_qemu_tb_exec为函数而非指针 


```shell
../configure --target-list=i386-softmmu,x86_64-softmmu --enable-tcg-interpreter --enable-tcg 
```

```shell
readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | grep "__app_func_call__"
# 54127: 000000000087a526     5 FUNC    GLOBAL DEFAULT   16 __app_func_call__
```

```shell
readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | grep "tcg_qemu_tb_exec"
# 45181: 000000000087a52b  6263 FUNC    GLOBAL DEFAULT   16 tcg_qemu_tb_exec
```
注意 tcg_qemu_tb_exec 是FUNC 而不是 OBJECT, 结合[ptr:tcg_qemu_tb_exec](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#ptrtcg_qemu_tb_exec) 、 [func:tcg_qemu_tb_exec](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#functcg_qemu_tb_exec) 可知 编译开关```CONFIG_TCG_INTERPRETER```是允许

##### 【结论】

###### 结论

1. 若 编译开关```CONFIG_TCG_INTERPRETER```是允许的， 则 有```函数tcg_qemu_tb_exec```
2. 若 编译开关```CONFIG_TCG_INTERPRETER```是禁止的， 则 有```函数指针变量tcg_qemu_tb_exec``` 指向 ```函数tcg_splitwx_to_rx``` 
3. 默认情况下 编译开关```CONFIG_TCG_INTERPRETER```是禁止的

###### elf中的tcg_qemu_tb_exec
```shell
readelf --symbols   /app/qemu/build-v8.2.2/qemu-system-x86_64 | grep "tcg_qemu_tb_exec"
#  45244: 00000000016d4a60     8 OBJECT  GLOBAL DEFAULT   28 tcg_qemu_tb_exec
```
注意 tcg_qemu_tb_exec 不是FUNC 而是 OBJECT ，   结合[ptr:tcg_qemu_tb_exec](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#ptrtcg_qemu_tb_exec) 、 [func:tcg_qemu_tb_exec](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/readme.md#functcg_qemu_tb_exec) 可知 编译开关```CONFIG_TCG_INTERPRETER```是禁止的

###### ```config-host.h```中的 CONFIG_TCG_INTERPRETER
```shell
find /app/qemu/build-v8.2.2 -name "*.h" | xargs -I% grep -Hn CONFIG_TCG_INTERPRETER  %
#/app/qemu/build-v8.2.2/config-host.h:352:#undef CONFIG_TCG_INTERPRETER
```
```/app/qemu/build-v8.2.2/config-host.h:352:#undef CONFIG_TCG_INTERPRETER``` 表明 编译开关 ```CONFIG_TCG_INTERPRETER``` 确实是禁止的 

##### 理由

###### ptr:tcg_qemu_tb_exec

https://gitee.com/imagg/qemu--qemu/blob/v8.2.2/tcg/tcg.c

```c++
// tcg/tcg.c


void tcg_prologue_init(void)
{
//...

#ifndef CONFIG_TCG_INTERPRETER
    tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
    // tcg_qemu_tb_exec 是函数指针， 指向函数 tcg_splitwx_to_rx
#endif
//...
```

###### func:tcg_qemu_tb_exec
https://gitee.com/imagg/qemu--qemu/blob/v8.2.2/tcg/tci.c

```c++
// tcg/tci.c
// 函数 tcg_qemu_tb_exec
uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                                            const void *v_tb_ptr)
{
// ...
}

```