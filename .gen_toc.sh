#!/usr/bin/env bash

source <(curl http://giteaz:3000/bal/bash-simplify/raw/tag/tag/release/gen_toc.sh)
# 【用法举例】 gen_tableOfContent  /app/wiki/ http://giteaz:3000/wiki/wiki/src/branch/main /app/wiki/readme.md

gen_tableOfContent  /fridaAnlzAp/app_bld/ http://giteaz:3000/frida_analyze_app_src/app_bld/src/branch/main /fridaAnlzAp/app_bld/readme.md 
