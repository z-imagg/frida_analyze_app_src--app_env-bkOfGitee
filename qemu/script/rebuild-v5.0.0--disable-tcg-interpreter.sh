#编译步骤
buildDir="/app/qemu/build-v8.2.2" && \
rm -fr $buildDir && mkdir $buildDir && cd $buildDir && \
#  以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --disable-tcg-interpreter --enable-tcg && \ 
make -j4
# make install

