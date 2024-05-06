
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

#dk# FROM ubuntu:22.04 as base
#dk# WORKDIR /
#dk# COPY ./hostRoot/app/app_env /app/app_env
#dk# COPY ./hostRoot/app/bash-simplify  /app/bash-simplify

#Dockerfile: 定义 'ARG x=...' , 使用 RUN 'echo $x; bash -x f_use_x.sh'
#dk# ARG pdir="$pdir"
#dk# ARG bsFlg="$bsFlg"

#dk# RUN bash -c ''' \
{ \
#标记此时是在docker镜像构建阶段
touch /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage && \
#粗略显示已复制文件
find /app/ -maxdepth 1 && \
#安装系统依赖包,此依赖包是基础,否则后续脚本可能无法执行
bash $bsFlg $pdir/depent/___sys.sh && \
#基本导入: 域名设置、_importBSFn 、 docker_instance.sh 、 isInDocker
source $pdir/docker_instance.sh && \
#循环执行依赖脚本
source $pdir/util/run_shLs_in_dir.sh && \
run_shLs_in_dir $pdir/depent && \
#基本需求: 域名设置、克隆基本仓库
source $pdir/util/repo_require.sh && \
true ;} \
|| false #dk# '''


#dk# LABEL maintainer="prgrmz07 <prgrmz07@163.com>"
#dk# LABEL version="0.1"
#dk# LABEL description="ubuntu22.04 proj 编译环境 docker "



#dk# ENTRYPOINT ["/bin/bash", "$pdir/util/dkEntry.sh" ]