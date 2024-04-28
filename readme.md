#### 术语
- bld == build
- app_bld == application build == 应用程序构建 == 应用程序编译
- env == docker env | real env == docker环境 或 真机环境



nconfig启用调试信息 编译产物vmlinux尺寸有629MB,   启用 ```  kernel hacking --> Compile-time checks and compiler options --> Compile the kernel with debug info```

```shell
ls -lh vmlinux
# -rwxrwxrwx   629M 2024年4月28日  vmlinux
file vmlinux
# vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=5889f078cdb9add1f631b183d5d4c8e268f596fc, with debug_info, not stripped
ls -lh arch/x86/boot/bzImage
# -rwxrwxrwx   9.5M 2024年4月28日 arch/x86/boot/bzImage
file arch/x86/boot/bzImage
# arch/x86/boot/bzImage: Linux kernel x86 boot executable bzImage, version 5.11.0 (root@ubuntu2204_linux5build) #1 SMP Sun Apr 28 06:52:15 UTC 2024, RO-rootFS, swap_dev 0X9, Normal VGA
```
