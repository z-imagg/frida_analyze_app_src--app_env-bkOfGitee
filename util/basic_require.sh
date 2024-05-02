#!/bin/bash

#【描述】  基本需求: 域名设置、克隆基本仓库
#【依赖】   
#【术语】 
#【备注】   

#本地域名总是要设置的
source /fridaAnlzAp/app_qemu/prj_env/util/LocalDomainSet.sh
#导入_importBSFn.sh
source /app/bash-simplify/_importBSFn.sh
_importBSFn "git_Clone_SwitchTag.sh"

#判定当前 是在docker实例中 还是 在 宿主物理机 中  .  返回变量为 inDocker
_importBSFn "isInDocker.sh" && isInDocker
#  删除 构建Dockerfile时 用的目录 /fridaAnlzAp/prj_env/env
$inDocker && ( mv /fridaAnlzAp /tmp_fridaAnlzAp ; mkdir -p /fridaAnlzAp/ ; \
mv app/bash-simplify /tmp_bash-simplify ;)

#克隆仓库app_qemu版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/frida_analyze_app_src/app_qemu.git"  "tag_release"  "/fridaAnlzAp/app_qemu"
#克隆仓库prj_env版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/frida_analyze_app_src/prj_env.git"  "tag_release"  "/fridaAnlzAp/prj_env"
#克隆仓库cmd-wrap版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/bal/cmd-wrap.git"  "tag_release"  "/app/cmd-wrap"
#克隆仓库bash-simplify版本tag_release
git_Clone_SwitchTag "http://giteaz:3000/bal/bash-simplify.git"  "tag_release"  "/app/bash-simplify"