#编译步骤
buildDir="/app/qemu/build-v8.2.2" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-linux-user,i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --disable-tcg && \ 
make -j4
# make install



#*-linux-user : 用户态模拟，  系统调用转发给物理宿主机操作系统
#*-softmmu    ：全系统模拟 