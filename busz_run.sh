
#执行业务脚本
# 业务脚本具有幂等性
pdir="$pdir" bsFlg="$bsFlg"  bash $bsFlg   $pdir/busz/linux_x86_64__build.sh
pdir="$pdir" bsFlg="$bsFlg"  bash $bsFlg   $pdir/busz/initRamFs_create.sh

