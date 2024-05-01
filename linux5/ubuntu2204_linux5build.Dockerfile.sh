
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY /fridaAnlzAp/app_qemu /fridaAnlzAp/app_qemu
#dk# COPY /fridaAnlzAp/prj_env /fridaAnlzAp/prj_env
#dk# COPY /app/bash-simplify  /app/bash-simplify

#dk# RUN bash -c ''' \
{ \
#安装系统依赖包
bash -x /fridaAnlzAp/app_qemu/app_bld/linux5/depent/sys.sh && \
#基本需求: 域名设置、克隆基本仓库
source /fridaAnlzAp/app_qemu/prj_env/util/basic_require.sh && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 linux5 编译环境 docker "



#dk# ENTRYPOINT [ "/fridaAnlzAp/app_qemu/app_bld/linux5/docker_entry.sh" ]