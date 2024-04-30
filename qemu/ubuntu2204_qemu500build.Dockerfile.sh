
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY /fridaAnlzAp/prj_env/env /fridaAnlzAp/prj_env/env
#dk# COPY /fridaAnlzAp/app_qemu/app_bld /fridaAnlzAp/app_qemu/app_bld
#dk# COPY /app/bash-simplify/local_domain_set.sh /app/bash-simplify/local_domain_set.sh
#dk# COPY /fridaAnlzAp/app_qemu/app_bld/qemu/busz_run.sh /root/busz_run.sh
#dk# COPY /fridaAnlzAp/app_qemu/app_bld/qemu/depent /fridaAnlzAp/app_qemu/app_bld/qemu/depent

#dk# RUN bash -c ''' \
{ \
#本地域名总是要设置的
source /fridaAnlzAp/app_qemu/app_bld/util/LocalDomainSet.sh && \
#导入_importBSFn.sh
source /fridaAnlzAp/app_qemu/app_bld/util/Load__importBSFn.sh && \
#安装系统依赖包
bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/depent/sys.sh && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 qemu5.0.0 编译环境 docker "



#dk# ENTRYPOINT [ "/fridaAnlzAp/app_qemu/app_bld/qemu/docker_entry.sh" ]