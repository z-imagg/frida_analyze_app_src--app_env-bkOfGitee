


 



#### 前置
frida监控qemu运行linux4内核 , http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md


#### frida监控qemu运行linux4内核 时，  frida跳过linux4内核中某些巨量函数调用 后， 约10分钟qemu能运行完linux4内核


##### 版本
按照标签: 
     http://giteaz:3000/frida_analyze_app_src/main/src/tag/tag/fridaAnlzAp/qemu__linux4__boot_ok3  
     https://gitee.com/imagg/qemu--qemu/tree/tag/fridaAnlzAp/qemu__linux4__boot_ok3

所用代码指纹如下
```shell
git --git-dir=/app/qemu/.git rev-parse HEAD
# 2e51efb4cadfac5dcdd371ec345292abe98240fe

git --git-dir=/fridaAnlzAp/main/.git rev-parse HEAD
# ee9dfe953ac4f8a97ffacc360fd228b5d9b2b892


md5sum /app/qemu/build-v8.2.2/qemu-system-x86_64
# c21e373d11757d342f716d19ed9c02cf  /app/qemu/build-v8.2.2/qemu-system-x86_64

```

##### 多次运行frida 找到巨量函数们
先运行一次 ```fridaJs_runApp.sh```获得日志文件```appOut-1713713504.log```，统计linux4内核中函数调用次数，巨量次数的函数地址如下：
    注意 估计 重新编译qemu后， 这些函数地址 会不一样 
```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713713504.log  | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
# 728396 555555b5d0e0
# 75774 555555b14c90
# 48476 555555b5e090
# 37826 555555b13e90
# 28562 555555b5e080
# 24906 555555b7a150
# 21084 555555b13ec0
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713714349.log   | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#  436570 555555b74000
#  436366 555555b7c920
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715134.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#  104280 555555b5e2c0
#后面没列出来的都是不足1万次
```

```shell
grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715453.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#   76881 555555b73310
#   17922 555555b13fb0
#   17646 555555b14000
#后面没列出来的都是不足1万次
```

##### 制作 配置文件 以 巨量函数们

排除巨量次数函数，如下：
```shell
cat  << 'EOF' > /tmp/FrdaIgnFnLs.txt
0x555555c4bcc0
0x555555b5de80
0x555555b5d0e0
0x555555b14c90
0x555555b5e090
0x555555b13e90
0x555555b5e080
0x555555b7a150
0x555555b13ec0
0x555555b74000
0x555555b7c920
0x555555b5e2c0
0x555555b73310
0x555555b13fb0
0x555555b14000
EOF
```

注意 本次qemu代码修改 最多只读取文件```/tmp/FrdaIgnFnLs.txt```的前20行（宏定义```#define _FrdaIgnFnLmt 20```），如果超出， 比如修改为60```#define _FrdaIgnFnLmt 60```

https://gitee.com/imagg/qemu--qemu/blob/tag/fridaAnlzAp/qemu__linux4__boot_ok3/system/main.c
```cpp
// file: system/main.c

//最大只能有FrdaIgnFnLmt个忽略地址
#define _FrdaIgnFnLmt 20
```

##### 跳过巨量函数们 后， frida 监控qemu 运行 linux4, 约10分钟运行完

再次执行```fridaJs_runApp.sh```，  日志会小很多, 居然就大约10分钟不到，就跑完了
```shell


wc -l  /fridaAnlzAp/frida_js/*.log 
#    37739 /fridaAnlzAp/frida_js/appOut-1713715689.log
#    37340 /fridaAnlzAp/frida_js/frida-out-Mix-1713715689.log
#    18667 /fridaAnlzAp/frida_js/frida-out-PrefixPure-1713715689.log
#    18667 /fridaAnlzAp/frida_js/frida-out-Pure-1713715689.log

ls -lh /fridaAnlzAp/frida_js/*.log
# -rw-r--r-- 1 root root 5.8M Apr 21 16:09 /fridaAnlzAp/frida_js/appOut-1713715689.log
# -rw-r--r-- 1 root root 5.7M Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-Mix-1713715689.log
# -rw-r--r-- 1 root root 5.7M Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-PrefixPure-1713715689.log
# -rw-r--r-- 1 root root 5.6M Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-Pure-1713715689.log

ls -l /fridaAnlzAp/frida_js/*.log
# -rw-r--r-- 1 root root 5996380 Apr 21 16:09 /fridaAnlzAp/frida_js/appOut-1713715689.log
# -rw-r--r-- 1 root root 5970680 Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-Mix-1713715689.log
# -rw-r--r-- 1 root root 5951258 Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-PrefixPure-1713715689.log
# -rw-r--r-- 1 root root 5839256 Apr 21 16:09 /fridaAnlzAp/frida_js/frida-out-Pure-1713715689.log

grep "__@__@"  /fridaAnlzAp/frida_js/appOut-1713715689.log    | cut -d'"' -f 20 | sort | uniq  --count | sort -nr
#    4866 555555b740f0
#    2724 555555b13f50
#    2250 555555b7c690
#    1936 555555b13f80
#    1780 555555b13ef0
#    1306 555555b13f20
#    1072 555555b73350
#     740 555555b73f60
#     664 555555b7a590
#     662 555555b65790
#     204 555555b14760
#     148 555555b142a0
#      74 555555b735a0
#      38 555555b653b0
#      26 555555b61200
#      22 555555b658b0
#      22 555555b611f0
#      22 555555b5ffa0
#      22 555555b11da0
#      12 555555b61240
#      12 555555b13c90
#      10 555555b7add0
#       6 555555b79b50
#       5 555555b14ca0
#       4 555555b7cae0
#       4 555555b7b010
#       4 555555b79df0
#       4 555555b73250
#       4 555555b61140
#       4 555555b61120
#       4 555555b60520
#       4 555555b5ff20
#       4 555555b5fe20
#       2 555555b60d50
#       2 555555b60ac0
#       2 555555b60970
#       2 555555b601e0

```



**命令备忘**

##### watch_appOut-X.log
监控日志文件 【形如 ```/fridaAnlzAp/frida_js/appOut-1713836715.log``` 】中 fnArgLs 的取值，  

```shell
watch -n 30 "grep '__@__@'  $(ls /fridaAnlzAp/frida_js/appOut-*.log | head -n 1)  | cut -d'\"' -f 20 | sort | uniq  --count | sort -nr"

```

注意如果frida_js改变了```console.log```样式，则上面的```-f 20```需要调整


