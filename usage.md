
### 使用手册
#### 公共部分

```shell
git clone -b brch_template http://giteaz:3000/frida_analyze_app_src/app_env.git /app/app_env
#lazygit --git-dir=/app/bash-simplify/.git --work-tree=/app/bash-simplify/
git clone -b tag_release http://giteaz:3000/bal/bash-simplify.git /app/bash-simplify
#lazygit  --git-dir=/app/app_env/.git --work-tree=/app/app_env/

```


#### hello_world

```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签
git_switch_to_remote_tag /app/app_env tag_release__helloWorld_v1_demo

```

```shell
#删除上次标记文件
rm -fv /tmp/flagDone_DkBuszRun  /tmp/flagDone_InitProj
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```

#### linux-v5.11

```shell
source /app/bash-simplify/git_switch_to_remote_tag.sh
#  将git仓库/app/app_env切换到远程标签tag_release__qemu_v8.2.2_build
git_switch_to_remote_tag /app/app_env tag_release__qemu_v8.2.2_build

```

```shell
#删除上次标记文件
rm -fv /tmp/flagDone_DkBuszRun  /tmp/flagDone_InitProj
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
#  将git仓库/app/app_env切换到远程标签tag_release__qemu_v8.2.2_build
git_switch_to_remote_tag /app/app_env tag_release__qemu_v8.2.2_build

```

```shell
#删除上次标记文件
rm -fv /tmp/flagDone_DkBuszRun  /tmp/flagDone_InitProj
#删除上次编译产物
rm -fv /app/qemu/build-v8.2.2
#宿主机上运行
bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
#docker实例上运行
bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
```