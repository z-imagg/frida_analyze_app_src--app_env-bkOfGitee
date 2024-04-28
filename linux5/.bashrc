
#使用手册文本
source /fridaAnlzAp/app_qemu/app_bld/linux5/manual_txt.sh

# 显示 使用手册文本
echo -e "$manual_txt"

#执行业务脚本
# 业务脚本具有幂等性
bash  /fridaAnlzAp/app_qemu/app_bld/linux5/busz/linux_x86_64__build.sh
bash  /fridaAnlzAp/app_qemu/app_bld/linux5/busz/initRamFs_create.sh

