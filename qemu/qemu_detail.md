#### 依赖搜索记录
```shell
apt install apt-file
apt-file update
```
```shell
apt-file search --regexp  "/pkg-config$"
#pkg-config: /usr/bin/pkg-config

apt-file search --regexp  "/ninja$"
#ninja-build: /usr/bin/ninja               

```



##### 一个备忘
原始编译```-O2 -g```:
```
71M /app/qemu/build-v8.2.2/qemu-system-x86_64
```


用cmd-wrap改为```-O1 -g1```， 没想到尺寸变小了 :
```
32M /app/qemu/build-v8.2.2/qemu-system-x86_64
```



#### qemu使用
```shell
/app/qemu/build-v8.2.2/qemu-system-x86_64 --help
```


##### 放弃 linux-0.11


http://giteaz:3000/bal/cmd-wrap/src/branch/fridaAnlzAp/app/qemu/build/qemu/drop__linux-0.11.md

##### linux4

http://giteaz:3000/bal/cmd-wrap/src/branch/fridaAnlzAp/app/qemu/build/qemu/linux4.md


#### compile_production
** 编译产物 **

##### 产物
```shell
find /app/qemu/build-v8.2.2/ -type f -executable -and \( ! -path '*/tests/*' \) -and  \( ! -path '*/pyvenv/*' \) -and \( ! -path '*/contrib/*'  \) | xargs -I@ ls -sh       @
#精确尺寸: '| xargs -I@ stat --format="%n %s"     @'
```

```txt
132K /app/qemu/build/subprojects/libvhost-user/link-test
14M /app/qemu/build/storage-daemon/qemu-storage-daemon
2.6M /app/qemu/build/qemu-edid
4.0K /app/qemu/build/config.status
70M /app/qemu/build/qemu-system-i386
11M /app/qemu/build/qemu-io
16K /app/qemu/build/meson-private/sanitycheckc.exe
11M /app/qemu/build/qemu-img
12M /app/qemu/build/qemu-nbd
2.6M /app/qemu/build/qemu-bridge-helper
3.7M /app/qemu/build/qga/qemu-ga
71M /app/qemu/build/qemu-system-x86_64
4.0M /app/qemu/build/qemu-pr-helper


```

##### qemu-system-i386 
1. 【描述】 ```file /app/qemu/build-v8.2.2/qemu-system-i386  ```

```txt
        /app/qemu/build/qemu-system-i386: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=8e16b9741d22e249c55d6868fe63d301c535d7a1, for GNU/Linux 3.2.0, with debug_info, not stripped
```

2. 【依赖】 ```ldd /app/qemu/build-v8.2.2/qemu-system-i386```
```txt
        linux-vdso.so.1 (0x00007ffd50af9000)
        libgio-2.0.so.0 => /lib/x86_64-linux-gnu/libgio-2.0.so.0 (0x00007a9f71f13000)
        libgobject-2.0.so.0 => /lib/x86_64-linux-gnu/libgobject-2.0.so.0 (0x00007a9f71eb3000)
        libglib-2.0.so.0 => /lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x00007a9f71d79000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007a9f71d5d000)
        libgmodule-2.0.so.0 => /lib/x86_64-linux-gnu/libgmodule-2.0.so.0 (0x00007a9f71d56000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007a9f71c6f000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007a9f71a44000)
        libmount.so.1 => /lib/x86_64-linux-gnu/libmount.so.1 (0x00007a9f71a00000)
        libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007a9f719d4000)
        libffi.so.8 => /lib/x86_64-linux-gnu/libffi.so.8 (0x00007a9f719c7000)
        libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007a9f71951000)
        /lib64/ld-linux-x86-64.so.2 (0x00007a9f73818000)
        libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007a9f71918000)
        libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007a9f71881000)
```

##### qemu-system-x86_64 
1. 【描述】```file /app/qemu/build-v8.2.2/qemu-system-x86_64```

```txt
        /app/qemu/build/qemu-system-x86_64: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=2aa26203fa5bdb52a2d0dfc020235ff9775ea910, for GNU/Linux 3.2.0, with debug_info, not stripped
```


2. 【依赖】 ```ldd /app/qemu/build-v8.2.2/qemu-system-x86_64```
```txt
        linux-vdso.so.1 (0x00007ffcd77ec000)
        libgio-2.0.so.0 => /lib/x86_64-linux-gnu/libgio-2.0.so.0 (0x000073999a0d7000)
        libgobject-2.0.so.0 => /lib/x86_64-linux-gnu/libgobject-2.0.so.0 (0x000073999a077000)
        libglib-2.0.so.0 => /lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x0000739999f3d000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x0000739999f21000)
        libgmodule-2.0.so.0 => /lib/x86_64-linux-gnu/libgmodule-2.0.so.0 (0x0000739999f1a000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x0000739999e33000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x0000739999c08000)
        libmount.so.1 => /lib/x86_64-linux-gnu/libmount.so.1 (0x0000739999bc4000)
        libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x0000739999b98000)
        libffi.so.8 => /lib/x86_64-linux-gnu/libffi.so.8 (0x0000739999b8b000)
        libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x0000739999b15000)
        /lib64/ld-linux-x86-64.so.2 (0x000073999b9e8000)
        libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x0000739999adc000)
        libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x0000739999a45000)
```
