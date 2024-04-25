cd /bal/linux-stable/ && \
make mrproper && \
make clean && \
make ARCH=x86_64 CC=gcc defconfig && \
make ARCH=x86_64 CC=gcc nconfig && \
make ARCH=x86_64 CC=gcc -j 6  V=1

#nconfig 和 menuconfig 都是 文本界面, 但 nconfig更好操作一些

#defconfig==default config==默认配置
#若去掉 nconfig 不会弹出修改配置菜单 


#linux-5.0 的 nconfig: 
# 试图启用调试
#   kernel hacking --> Compile-time checks and compiler options --> Compile the kernel with debug info
#   General --> Configure standard kernel features(expert users) --> Include all symbols in kallsyms
#   kernel hacking --> Kernel debugging
# 启用PVH:
#   Processor type and features --> Linux guest support  --> Support for running PVH guests

#nconfig 生成的配置保存在文件.config中,  mrproper && clean 会删除 .config文件