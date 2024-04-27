
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY /fridaAnlzAp/prj_env/env /fridaAnlzAp/prj_env/env
#dk# COPY /fridaAnlzAp/app_qemu/app_bld /fridaAnlzAp/app_qemu/app_bld
#dk# COPY /app/bash-simplify/local_domain_set.sh /app/bash-simplify/local_domain_set.sh

#dk# RUN bash -c ''' \
{ \
ArgAptGet="-qq   -y" && \
# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
( set -x && \
apt-get $ArgAptGet update && \
apt-get $ArgAptGet install  build-essential 1>/dev/null && \
#libncurses5-dev被menuconfig需要
apt-get $ArgAptGet install libncurses5-dev 1>/dev/null && \
#解决报错: 找不到 flex、找不到 bison
#  flex bison 被linux-5.0需要,  但linux-4.14-y不需要
apt-get $ArgAptGet install flex bison 1>/dev/null && \
#解决报错: 找不到 ssl/bio.h
apt-get $ArgAptGet install libssl-dev 1>/dev/null && \
#解决报错: 找不到bc
apt-get $ArgAptGet install bc 1>/dev/null && \
##解决报错
apt-get $ArgAptGet install libelf-dev  1>/dev/null && \
#工具
apt-get $ArgAptGet install git file cpio wget curl 1>/dev/null && \
# gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609
gcc --version ;) && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu16.04 linux5 编译环境 docker "



#dk# ENTRYPOINT [ "/fridaAnlzAp/app_qemu/app_bld/linux5/docker_entry.sh" ]