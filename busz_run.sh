
#执行业务脚本
# 业务脚本具有幂等性
pdir="$pdir" bsFlg="$bsFlg" inDocker=$inDocker bash $bsFlg   $pdir/busz/linux_x86_64__build.sh
pdir="$pdir" bsFlg="$bsFlg" inDocker=$inDocker bash $bsFlg   $pdir/busz/initRamFs_create.sh

