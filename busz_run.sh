



#业务脚本们路径 读取到 BASH变量buszScriptFPath_Arr中
mapfile -t buszScriptFPath_Arr < <(find $pdir/busz/ -type f | sort --unique )

echo "业务脚本路径数组:【${buszScriptFPath_Arr[@]}】"

#循环执行业务脚本
for buszScriptFPathK in "${buszScriptFPath_Arr[@]}"; do
    # 业务脚本具有幂等性
    pdir="$pdir" bsFlg="$bsFlg"  bash $bsFlg  "$buszScriptFPathK"
done