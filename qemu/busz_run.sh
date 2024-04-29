

#执行业务脚本
# 业务脚本具有幂等性
bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/busz/rebuild-qemu-v8.2.2--disable-tcg-interpreter--disable-tcg.sh
bash -x /fridaAnlzAp/app_qemu/app_bld/qemu/busz/qemu_boot_vmlinux.sh

