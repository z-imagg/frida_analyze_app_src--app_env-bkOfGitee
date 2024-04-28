
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY /fridaAnlzAp/prj_env/env /fridaAnlzAp/prj_env/env
#dk# COPY /fridaAnlzAp/app_qemu/app_bld /fridaAnlzAp/app_qemu/app_bld
#dk# COPY /app/bash-simplify/local_domain_set.sh /app/bash-simplify/local_domain_set.sh
#dk# COPY /fridaAnlzAp/app_qemu/app_bld/qemu/.bashrc /root/.bashrc

#dk# RUN bash -c ''' \
{ \
ArgAptGet="-qq   -y" && \
# 在子shell进程开启繁琐模式 即 (set -x ; ... ;)
( set -x && \
apt-get $ArgAptGet update && \
apt-get $ArgAptGet install  build-essential python3-venv python3-pip  ninja-build pkg-config libglib2.0-dev 1>/dev/null && \
##  qemu 5.0.0 、 6.2.0  需要的依赖，  qemu v8.2.2 不需要
apt-get $ArgAptGet install libpixman-1-dev  libpixman-1-0   1>/dev/null && \
apt-get $ArgAptGet install git curl   1>/dev/null && \
pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple && \
#解决报错: 找不到 ssl/bio.h
gcc --version ;) && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 qemu5.0.0 编译环境 docker "



#dk# ENTRYPOINT [ "/fridaAnlzAp/app_qemu/app_bld/qemu/docker_entry.sh" ]