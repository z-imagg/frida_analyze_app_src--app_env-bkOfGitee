```shell
make mrproper
make clean
make ARCH=i386 CC=gcc defconfig
make ARCH=i386 CC=gcc menuconfig
make ARCH=i386 CC=gcc -j 6  V=1
```

https://www.kerneltravel.net/blog/2021/debug_kernel_szp/




```shell
docker run --privileged=true --volume /bal/linux-stable/:/bal/linux-stable/  --name u16 --hostname u16 -itd ubuntu:16.04

#include/linux/compiler-gcc.h:100:30: fatal error: linux/compiler-gcc5.h: No such file or directory

cd /bal/linux-stable/include/linux/; ls compiler-gcc*
# compiler-gcc.h  compiler-gcc3.h  compiler-gcc4.h

```

https://en.wikipedia.org/wiki/Ubuntu_version_history