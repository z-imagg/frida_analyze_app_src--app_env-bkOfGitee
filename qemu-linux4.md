
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
```shell
#编译步骤
buildDir="/app/qemu/build-v5.0.0" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter   && \ 
make -j4
# make install



```