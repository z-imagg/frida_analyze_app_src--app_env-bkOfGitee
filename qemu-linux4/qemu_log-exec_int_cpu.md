qemu显示linux4中函数地址的日志:
```/app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64 -d exec,int,cpu -D qemu.log```

发现过程如下:

1.
```./x86_64-softmmu/qemu-system-x86_64 --help|grep log```
```
-d item1,...    enable logging of specified items (use '-d help' for a list of log items)
-D logfile      output log to logfile (default stderr)
```


```./x86_64-softmmu/qemu-system-x86_64 -d help```

```
Log items (comma separated):
...
int             show interrupts/exceptions in short format
exec            show trace before each executed TB (lots of logs)
cpu             show CPU registers before entering a TB (lots of logs)
...
```

2.
以下搜索 ```CPU_LOG_EXEC```

https://gitee.com/imagg/qemu--qemu/blob/v5.0.0/util/log.c

```cpp

const QEMULogItem qemu_log_items[] = {
   //...
    { CPU_LOG_EXEC, "exec",//
      "show trace before each executed TB (lots of logs)" },
   //...
};
```


###### cpu-exec.c/cpu_tb_exec/qemu_log_mask_and_addr
https://gitee.com/imagg/qemu--qemu/blob/v5.0.0/accel/tcg/cpu-exec.c

```cpp
static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
{
    //...

    qemu_log_mask_and_addr(CPU_LOG_EXEC,  //
    itb->pc,
                           "Trace %d: %p ["
                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
                           cpu->cpu_index, itb->tc.ptr,
                           itb->cs_base, itb->pc, itb->flags,
                           lookup_symbol(itb->pc));
```