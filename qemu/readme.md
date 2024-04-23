放弃 qemu解释性的tcg的原因, [drop-qemu-tcg-reason](http://giteaz:3000/frida_analyze_app_src/app_bld/src/commit/c7b319acc11509162614aa6858d6c7e20ec981df/qemu/linux4/frida_qemu_linux4_flag__spy_func.md#drop-qemu-tcg-reason)


最后的提交：

qemu: 
https://gitee.com/imagg/qemu--qemu/blob/d3a9fdebb51ccd87f6763cb3651d322708b3c18e

https://gitee.com/imagg/qemu--qemu/blob/8f322fc49ed017ca9c1634c93ed740b88f214cd9

linux:
https://gitee.com/repok/linux/commit/44b77f186330121620025f8171aa437558c4d99f




原始readme.md, http://giteaz:3000/frida_analyze_app_src/app_bld/src/commit/775eafba68b1e661eab6c0d1918bd5c4d5df3bd0/qemu/readme.old.md



最后， qemu使用tcg时 的调用栈 ， https://gitee.com/imagg/qemu--qemu/blob/cbb0122c548e1d85b2c545c527a9389526fd6798/gdb_loop_find__qemu_linux4.sh

```txt
#2  0x0000555555e434f2 in tcg_qemu_tb_exec (env=env@entry=0x555556fb7500, v_tb_ptr=v_tb_ptr@entry=0x7fffb2e34f40) at ../tcg/tci.c:456
#3  0x0000555555c4ae9a in cpu_tb_exec (cpu=cpu@entry=0x555556fb4d40, itb=itb@entry=0x7fffb2e34e80, tb_exit=tb_exit@entry=0x7ffff6c53700) at ../accel/tcg/cpu-exec.c:458
#4  0x0000555555c4b166 in cpu_loop_exec_tb (cpu=cpu@entry=0x555556fb4d40, tb=tb@entry=0x7fffb2e34e80, pc=pc@entry=3321145556, last_tb=last_tb@entry=0x7ffff6c53708, tb_exit=tb_exit@entry=0x7ffff6c53700) at ../accel/tcg/cpu-exec.c:919
#5  0x0000555555c4b419 in cpu_exec_loop (cpu=cpu@entry=0x555556fb4d40, sc=sc@entry=0x7ffff6c537a0) at ../accel/tcg/cpu-exec.c:1040
#6  0x0000555555c4bc51 in cpu_exec_setjmp (cpu=cpu@entry=0x555556fb4d40, sc=sc@entry=0x7ffff6c537a0) at ../accel/tcg/cpu-exec.c:1057
#7  0x0000555555c4c300 in cpu_exec (cpu=cpu@entry=0x555556fb4d40) at ../accel/tcg/cpu-exec.c:1083
#8  0x0000555555c6e274 in tcg_cpus_exec (cpu=cpu@entry=0x555556fb4d40) at ../accel/tcg/tcg-accel-ops.c:76
#9  0x0000555555c6e3bf in mttcg_cpu_thread_fn (arg=arg@entry=0x555556fb4d40) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
#10 0x0000555555df40b1 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:541
#11 0x00007ffff78eaac3 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
#12 0x00007ffff797c850 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

```
注意 从此调用栈 中  tcg_qemu_tb_exec的上层cpu_tb_exec一定是可以选择不使用tcg的， 而不选择tcg肯定是直接使用linux4内核 这是我关注的