```shell
make mrproper
make clean
make ARCH=i386 CC=gcc defconfig
make ARCH=i386 CC=gcc menuconfig
make ARCH=i386 CC=gcc -j 6  V=1
```

https://www.kerneltravel.net/blog/2021/debug_kernel_szp/