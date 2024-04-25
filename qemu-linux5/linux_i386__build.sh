cd /bal/linux-stable/ && \
make mrproper && \
make clean && \
make ARCH=i386 CC=gcc defconfig && \
make ARCH=i386 CC=gcc menuconfig && \
make ARCH=i386 CC=gcc -j 6  V=1


#defconfig==default config==默认配置
#若去掉 menuconfig 不会弹出修改配置菜单 


#linux-5.0 的 menuconfig: 
# 试图启用调试
#   kernel hacking --> Compile-time checks and compiler options --> Compile the kernel with debug info
#   General --> Configure standard kernel features(expert users) --> Include all symbols in kallsyms
#   kernel hacking --> Kernel debugging
# 启用PVH:
#   Processor type and features --> Linux guest support  --> Support for running PVH guests

#menuconfig 生成的配置保存在文件.config中,  mrproper && clean 会删除 .config文件