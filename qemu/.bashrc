
#使用手册文本
source /fridaAnlzAp/app_qemu/app_bld/qemu/manual_txt.sh

# 显示 使用手册文本
echo -e "$manual_txt"


#执行业务脚本
# 业务脚本具有幂等性
bash  /fridaAnlzAp/app_qemu/app_bld/qemu/busz/rebuild-qemu-v5.0.0--disable-tcg-interpreter--disable-tcg.sh
bash  /fridaAnlzAp/app_qemu/app_bld/qemu/busz/qemu_boot_vmlinux.sh

