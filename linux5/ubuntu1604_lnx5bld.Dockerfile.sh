
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY /fridaAnlzAp/prj_env/env /fridaAnlzAp/prj_env/env
#dk# COPY /fridaAnlzAp/app_qemu/app_bld /fridaAnlzAp/app_qemu/app_bld

#dk# RUN bash -c ''' \
{ \
apt-get update && \
apt-get install -y  build-essential && \
#libncurses5-dev被menuconfig需要
apt-get install -y libncurses5-dev && \
#解决报错: 找不到 flex、找不到 bison
#  flex bison 被linux-5.0需要,  但linux-4.14-y不需要
apt-get install -y flex bison && \
#解决报错: 找不到 ssl/bio.h
apt-get install -y libssl-dev && \
#解决报错: 找不到bc
apt-get install -y bc && \
##解决报错
apt-get install -y libelf-dev  && \
#工具
apt-get install -y git file cpio wget curl && \
# gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609
gcc --version  && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu16.04 linux5 编译环境 docker "



#dk# ENTRYPOINT [ "/fridaAnlzAp/app_qemu/app_bld/linux5/docker_entry.sh" ]