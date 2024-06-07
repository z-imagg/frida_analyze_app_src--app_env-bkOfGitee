
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

#### sleuthkit-4.12.1
```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__sleuthkit-4.12.1_build

```

```shell
#删除上次标记文件:docker镜像构建
rm -fv  /app/app_env/flag_dockerBuildImage /app/bash-simplify/flag_dockerBuildImage
#删除上次标记文件:docker实例执行
prjNm=sleuthkit; rm -fv /tmp/{flagDone_DkBuszRun_$prjNm,flagDone_InitProj_$prjNm}
#删除上次编译产物
# rm -fv /app/sleuthkit/build-4.12.1
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```