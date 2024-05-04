
#### 日常开发

更新代码、清理上一次的标记痕迹
```shell
#更新到 分支 brch_release 、 标签 tag_release
#   lazygit标签更新操作:  到"Tag"页-->选中"tag_release"按d删除本地标签-->按u即拉取远程标签
lazygit --git-dir=/app/bash-simplify/.git --work-tree=/app/bash-simplify/
#更新到 分支 brch_release 、 标签 tag_release
lazygit  --git-dir=/app/app_env/.git --work-tree=/app/app_env/

#删除上次标记文件
rm -fv /tmp/flagDone_DkBuszRun  /tmp/flagDone_InitProj
#删除上次编译产物
rm -fv /app/linux/vmlinux
#删除上次编译产物
rm -fr /app/qemu/build-v8.2.2
```

宿主机上运行
```shell
# bash -x /app/app_env/main.sh false "bsFlg='-x -u'"
# bash +x /app/app_env/main.sh false "bsFlg='-x -u'"
# bash +x /app/app_env/main.sh false "bsFlg='+x -u'"
```

docker实例上运行
```shell
# bash -x /app/app_env/main.sh true "bsFlg='-x -u'"
# bash +x /app/app_env/main.sh true "bsFlg='-x -u'"
# bash +x /app/app_env/main.sh true "bsFlg='+x -u'"
```
