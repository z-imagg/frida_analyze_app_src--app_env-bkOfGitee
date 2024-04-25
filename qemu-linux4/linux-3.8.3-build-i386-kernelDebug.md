```shell
make mrproper
make clean
make ARCH=i386 CC=gcc defconfig
make ARCH=i386 CC=gcc menuconfig
make ARCH=i386 CC=gcc -j 6  V=1
```

启用内核调试 ，这个参考对吗？   https://www.kerneltravel.net/blog/2021/debug_kernel_szp/


```shell
cd /bal/linux-stable/include/linux/; ls compiler-gcc*
# compiler-gcc.h  compiler-gcc3.h  compiler-gcc4.h
```

ubuntu版本历史 ，  https://en.wikipedia.org/wiki/Ubuntu_version_history

1. ubuntu 22.04下报错:
```shell
#include/linux/compiler-gcc.h:100:1: fatal error: linux/compiler-gcc11.h: No such file or directory
```



2. ubuntu 16.04下报错:
```shell
docker pull ubuntu:16.04
docker run --privileged=true --volume /bal/linux-stable/:/bal/linux-stable/  --name u16 --hostname u16 -itd ubuntu:16.04

#include/linux/compiler-gcc.h:100:30: fatal error: linux/compiler-gcc5.h: No such file or directory


3. ubuntu 14.04:

```

```shell
docker pull ubuntu:14.04
docker run --privileged=true --volume /bal/linux-stable/:/bal/linux-stable/  --name u14 --hostname u14 -itd ubuntu:14.04


```