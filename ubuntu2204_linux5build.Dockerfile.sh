
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY ./hostRoot/app/app_env /app/app_env
#dk# COPY ./hostRoot/app/bash-simplify  /app/bash-simplify

#dk# ARG pdir="$pdir"

#dk# RUN bash -c ''' \
{ \
#安装系统依赖包
echo "pdir=$pdir" && \
bash -x $pdir/depent/sys.sh && \
#基本需求: 域名设置、克隆基本仓库
source $pdir/util/basic_require.sh && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 linux5 编译环境 docker "



#dk# ENTRYPOINT ["/bin/bash", "$pdir/docker_entry.sh" ]