
#执行业务脚本
# 业务脚本具有幂等性
find /fridaAnlzAp/app_qemu/app_bld/linux5/busz/ -type  | xargs -I% bash -x %