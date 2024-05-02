
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY ./hostRoot/fridaAnlzAp/app_qemu /fridaAnlzAp/app_qemu
#dk# COPY ./hostRoot/fridaAnlzAp/prj_env /fridaAnlzAp/prj_env
#dk# COPY ./hostRoot/app/bash-simplify  /app/bash-simplify

#dk# RUN bash -c ''' \
{ \
#安装系统依赖包
bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/depent/sys.sh && \
#基本需求: 域名设置、克隆基本仓库
source /fridaAnlzAp/app_qemu/app_bld/util/basic_require.sh && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 qemu5.0.0 编译环境 docker "



#dk# ENTRYPOINT ["/bin/bash", "-x", "/fridaAnlzAp/app_qemu/app_bld/qemu/docker_entry.sh" ]