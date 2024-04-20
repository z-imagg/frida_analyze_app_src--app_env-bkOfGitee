#### interceptor_compiler_gcc_g++

对编译器施加拦截步骤：

1. [remove_interceptor](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#remove_interceptor)
2. [add_interceptor](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#add_interceptor)
3. [app_build_step](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#app_build_step)
4. [remove_interceptor](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#remove_interceptor)

**开始编译前，撤销拦截器、放置拦截器**

##### 撤销拦截器
http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#remove_interceptor

##### add_interceptor


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

##### app_build_step
应用程序编译步骤正文， 略，根据实际情况进行

##### remove_interceptor
**编译完成后，撤销拦截器**

```shell
#撤销拦截器
bash /app/cmd-wrap/script/remove_interceptor.sh


#  若上文 已 建立python虚拟环境 /app/cmd-wrap/.venv/， 才需要此句
# deactivate
```