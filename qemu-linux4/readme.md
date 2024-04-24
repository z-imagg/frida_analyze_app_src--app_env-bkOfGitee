
科学上网 克隆git仓库、递归克隆子仓库
```shell
source  /app/wiki/computer/bash_completion/bash_completion-gitproxy.md.sh
#gitproxy <两次tab> 有如下提示，根据需要修改，获得：
git config --global http.proxy socks5://westgw:7890 ; 
git config --global https.proxy socks5://westgw:7890  ; 
git clone -b v5.0.0 --recurse-submodules https://github.com/qemu/qemu.git  ;    
git config --global --unset http.proxy ; 
git config --global --unset https.proxy


```

qemu-v5.0.0 禁止tcg解释器 编译步骤

可选，启用拦截器
```shell
bash -x /app/cmd-wrap/script/cmd_setup.sh
```

```shell
#编译步骤
buildDir="/app/qemu/build-v5.0.0" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --enable-debug-tcg  && \ 
make -j4
# make install
```

可选，移除拦截器
```shell
bash /app/cmd-wrap/script/remove_interceptor.sh
```

qemu运行linux4
```shell
/app/qemu/build-v5.0.0/x86_64-softmmu/qemu-system-x86_64 -nographic  -append "console=ttyS0"  -kernel  /bal/linux-stable/arch/x86/boot/bzImage -initrd /bal/bldLinux4RunOnBochs/initramfs-busybox-i686.cpio.tar.gz

```
其他, http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu-linux4/misc.md