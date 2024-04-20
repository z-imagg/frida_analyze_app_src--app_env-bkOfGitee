#### interceptor_compiler_gcc_g++

##### add_interceptor

**开始编译前，放置拦截器**

基于拦截器版本， [cmd-wrap.git/4659a](http://giteaz:3000/bal/cmd-wrap/commit/4659ac5f7352e34cf055b7769b6eaaaa5fb6882a)  ,  [cmd-wrap.git/tag_release](http://giteaz:3000/bal/cmd-wrap/src/tag/tag_release)

```shell
git clone -b tag_release http://giteaz:3000/bal/cmd-wrap.git   /app/cmd-wrap

#只有 当前未激活miniconda3时，才需要此句
#  建立python虚拟环境 /app/cmd-wrap/.venv/
# bash /app/cmd-wrap/script/env_prepare.sh

#编写 原始命令、入口命令
bash -x /app/cmd-wrap/script/cmd_setup.sh

which c++ #/usr/bin/c++

readlink -f $(which c++) #/app/cmd-wrap/bin/interceptor_xx.py

which python #/app/cmd-wrap/.venv/bin/python

python --version #Python 3.10.12

```

##### 编译正文
略，根据实际情况进行

##### remove_interceptor
**编译完成后，撤销拦截器**

```shell
#撤销拦截器
bash /app/cmd-wrap/script/remove_interceptor.sh


#  若上文 已 建立python虚拟环境 /app/cmd-wrap/.venv/， 才需要此句
# deactivate
```