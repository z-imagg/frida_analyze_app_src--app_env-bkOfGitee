#!/usr/bin/bash

#【描述】  
#【依赖】   
#【术语】 
#【备注】  

# 转换 x.Dockerfile.sh ， 停止、删除  实例 ， 删除、构建 镜像
function convert_sh_to_Dockerfile__rmInst__rmImg__bldImg() {
    #去此函数的直接调用者函数所在文件的目录 == 去父亲函数所在目录
    source  /app/bash-simplify/cdFatherScriptDir.sh && cdFatherScriptDir

    #文案，脚本用法
    declare -r exitCode_errUsage=3
    declare -r usage="usage syntax: '$0 ImgName version' ; such as, x 0.1 == x.Dockerfile.sh --> x.Dockerfile, tag == x:0.1 ;  exit code $exitCode_errUsage"

    #若 脚本参数不够，则退出
    declare -r exitCode_errNoShFile=3
    [[ $# -lt 2 ]] && { echo $usage && exit $exitCode_errUsage ;}

    #脚本参数定义
    ImgName=$1  #ImgName==base_ubuntu_22.04, ImgName==frida_anlz_ap
    ver=$2      #ver==01, ver==0.1_prv
    shF="${ImgName}.Dockerfile.sh"
    dockerF="${ImgName}.Dockerfile"
    tag="${ImgName}:${ver}"  #tag==base_ubuntu_22.04:01, tag==frida_anlz_ap:0.1_prv


    #若 输入文件 x.Dockerfile.sh 不存在 ，则退出
    declare -r errTxt_NoShFile="usage syntax: $shF not existed,  exit code  $exitCode_errNoShFile"
    [[ -f $shF ]] || { echo $errTxt_NoShFile && exit $exitCode_errNoShFile ;}

    #执行sh转Dockerfile :  x.Dockerfile.sh  --->  x.Dockerfile
    cp -v $shF $dockerF
    # 替换1
    python3 /app/bash-simplify/ReplaceStrInFile.py $dockerF '$pdir'         "$pdir"
    # 替换2
    python3 /app/bash-simplify/ReplaceStrInFile.py $dockerF "#dk# '''"      ""
    # 替换3 
    python3 /app/bash-simplify/ReplaceStrInFile.py $dockerF "#dk# "         ""
    #   替换2 先于 替换3 ，因为3是2的子串

    #打印提示消息
    echo "converted: $shF ---> $dockerF . pwd=$(pwd)"

    #停止、删除现有  实例
    instanceIdLs=$(docker ps -a  -q --filter "ancestor=${tag}")
    [[ "x" == "x$instanceIdLs" ]] || { docker stop $instanceIdLs && docker rm $instanceIdLs ;}

    #删除现有  镜像
    imageIdLs=$(docker images -q  --filter "reference=${ImgName}")
    [[ "x" == "x$imageIdLs" ]] || { docker image rm $imageIdLs ;}

    #删除现有  progrmz07/镜像 
    #  这是用于上传到docker.hub的镜像
    imageIdLs=$(docker images -q  --filter "reference=prgrmz07/${ImgName}")
    [[ "x" == "x$imageIdLs" ]] || { docker image rm $imageIdLs ;}

    #构建镜像
    #  在.Dockfile的RUN脚本中使用的本地域名
    docker build  --add-host=giteaz:10.0.4.9 --add-host=westgw:10.0.4.9  --progress=plain --no-cache    -f "$dockerF"    -t "$tag"     "/hostTop" 
}
