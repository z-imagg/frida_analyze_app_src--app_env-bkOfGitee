
#### 拦截编译器（正常编译可不拦截，但分析业务需要拦截）

拦截编译器步骤 ， http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/cmd-wrap.md#interceptor_compiler_gcc_g


cmd-wrap拦截到的qemu编译命令例子，  http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/cmd-wrap-example-complile-cmd/cc-1713609271802564436-53625.log



#### build-qemu


#### qemu编译docker环境

```base_ubuntu_22.04.04:0.1 ``` 来自 http://giteaz:3000/frida_analyze_app_src/main/src/branch/fridaAnlzAp/docker/docker/main_dockerImage_build_run.sh

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/env/base_ubuntu_22.04.Dockerfile.sh

```shell
docker run -itd --name u22 --hostname u22_dk base_ubuntu_22.04:0.1
docker exec -it u22 bash
```

##### build-qemu-step

**编译qemu正文**

参考, https://hlyani.github.io/notes/openstack/qemu_make.html

```shell
apt install -y python3-venv python3-pip  ninja-build pkg-config libglib2.0-dev
# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple

#qemu 6.2.0  需要的依赖，  qemu v8.2.2 不需要
sudo apt install libpixman-1-dev  libpixman-1-0  

git clone -b v8.2.2 https://gitee.com/imagg/qemu--qemu.git /app/qemu
#file /app/qemu--qemu/.git/config

mkdir /app/qemu/build-v8.2.2; cd /app/qemu/build-v8.2.2;
#以下三行为编译步骤
../configure --target-list=i386-softmmu,x86_64-softmmu --enable-tcg-interpreter --enable-tcg 
make -j4
# make install

```

```--enable-tcg-interpreter --enable-tcg ``` 使得   [tcg_qemu_tb_exec 为函数而非指针](http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/qemu_tcg_qemu_tb_exec.md)


#### qemu运行linux4

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/qemu_linux4.md


#### frida监控qemu运行linux4内核
http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4.md


#### frida监控qemu运行linux4内核 时，  frida跳过linux4内核中某些巨量函数调用 后， 约10分钟qemu能运行完linux4内核

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4_ignoreHugeFunc.md


#### frida监控qemu运行linux4内核 ，linux4源码中新加入特定标记参数值的函数调用， frida由该参数值找到函数地址 与 System.map 中地址比对 获得 qemu 对 linux4函数地址 变换规律

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4//frida_qemu_linux4_flag__spy_func.md

**以下是非主流程内容**

#### qemu编译产物

http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/qemu_detail.md#compile_production


#### qemu若干函数
http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/qemu_some_func.md


#### frida监控qemu运行linux4内核 时，   跟踪tcg_gen_code函数
http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main/qemu/linux4/frida_qemu_linux4_traceFunc.md
