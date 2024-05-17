
### 使用手册
#### 公共部分

```shell
rm -fr /app/app_env/ /app/bash-simplify/ 
rm -fv /tmp/flagDone*
```

```shell
git clone -b brch_template http://giteaz:3000/frida_analyze_app_src/app_env.git /app/app_env
#lazygit --git-dir=/app/bash-simplify/.git --work-tree=/app/bash-simplify/
git clone -b tag_release http://giteaz:3000/bal/bash-simplify.git /app/bash-simplify
#lazygit  --git-dir=/app/app_env/.git --work-tree=/app/app_env/

```


#### hello-world

https://gitee.com/repok/hello-world/tree/v1

```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__hello-world_v1_demo

```

```shell
#删除上次标记文件:docker镜像构建
rm -fv  /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage
#删除上次标记文件:docker实例执行
prjNm=hello-world_v1_demo; rm -fv /tmp/{flagDone_DkBuszRun_$prjNm,flagDone_InitProj_$prjNm}
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```


#### ap-run-anlz v1 prj-env

```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__ap-run-anlz_v1-q822l511_prj-env

```

```shell
#删除上次标记文件:docker镜像构建
rm -fv  /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage
#删除上次标记文件:docker实例执行
prjNm=prj-env; rm -fv /tmp/{flagDone_DkBuszRun_$prjNm,flagDone_InitProj_$prjNm}
#删除上次安装产物?
# rm -fv /app/
#宿主机上运行
# bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```


#### linux-v5.11

```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__linux_v5.11_build

```

```shell
#删除上次标记文件:docker镜像构建
rm -fv  /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage
#删除上次标记文件:docker实例执行
prjNm=linux; rm -fv /tmp/{flagDone_DkBuszRun_$prjNm,flagDone_InitProj_$prjNm}
#删除上次编译产物
rm -fv /app/linux/vmlinux
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```


#### qemu-v8.2.2
```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__qemu_v8.2.2_build

```

```shell
#删除上次标记文件:docker镜像构建
rm -fv  /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage
#删除上次标记文件:docker实例执行
#  /tmp/flagDone_InitProj_qemu_v8.2.2_build   /tmp/flagDone_DkBuszRun_qemu_v8.2.2_build
prjNm=qemu_v8.2.2_build; rm -fv /tmp/{flagDone_InitProj_$prjNm,flagDone_DkBuszRun_$prjNm}
#删除上次编译产物
rm -frv /app/qemu/build-v8.2.2
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```