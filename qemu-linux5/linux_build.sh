cd /bal/linux-stable/ && \
make mrproper && \
make clean && \
make ARCH=i386 CC=gcc defconfig && \
make ARCH=i386 CC=gcc menuconfig && \
make ARCH=i386 CC=gcc -j 6  V=1


#defconfig==default config==默认配置
#若去掉 menuconfig 不会弹出修改配置菜单 