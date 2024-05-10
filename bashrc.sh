#!/bin/bash

#【描述】  bash的rcfile
#【依赖】   
#【术语】 
#【备注】 

enterEnvMsg="fridaAnlzAp环境"
OkEnvMsg="fridaAnlzAp环境 ok: [Miniconda3, neo4j-community, cytoscape]"

echo $enterEnvMsg && \
#git设置
source /app/bash-simplify/git_settings.sh
#激活
# 激活 miniconda
source /app/Miniconda3-py310_22.11.1-1/bin/activate && \
# 激活 nvm
source /app/nvm/nvm.sh && \
# 激活 neo4j
function neo4j_inst_new() {
#【术语】 template == tmpl , inst==instance==neo4j_instance==neo4j实例, cfg==config
local instIdx=$1
[[ "X$instIdx" == "X" ]] && return 55
local neo4j_app_tmpl="/app/neo4j-community-4.4.32"
local neo4j_app_new="$neo4j_app_tmpl--qemu8Thread${instIdx}"
cp -r $neo4j_app_tmpl $neo4j_app_tmpl--qemu8Thread${instIdx}
local portA_tmpl=7474
local portB_tmpl=7687
#7474的千位的7减(instIdx+1) ， 比如 7474 --> 6474
local portA_new=$(( portA_tmpl - (instIdx+1)*1000 ))
#7687的千位的7减(instIdx+1) ， 比如 7687 --> 6687
local portB_new=$(( portB_tmpl - (instIdx+1)*1000 ))
local cfg_tmpl=$neo4j_app_tmpl/conf/neo4j.conf
local cfg_new=$neo4j_app_new/conf/neo4j.conf
sed -i -e "s/$portA_tmpl/$portA_new/g" -e "s/$portB_tmpl/$portB_new/g"  $cfg_new && diff $cfg_tmpl  $cfg_new
}
#  neo4j-community三个实例对应qemu8的三个线程
#qemu8Thread0 端口 6474、6687
neo4j_inst_new 0 && \
alias neo4j_alias_qemu8Thread0='_neo4jHm=/app/neo4j-community-4.4.32--qemu8Thread0 ; _java11Hm=/app/zulu11.70.15-ca-jdk11.0.22-linux_x64 ;    NEO4J_HOME=$_neo4jHm JAVA_HOME=$_java11Hm    PATH=$PATH:$_java11Hm/bin  $_neo4jHm/bin/neo4j'
#qemu8Thread1 端口 5474、5687
neo4j_inst_new 1 && \
alias neo4j_alias_qemu8Thread1='_neo4jHm=/app/neo4j-community-4.4.32--qemu8Thread1 ; _java11Hm=/app/zulu11.70.15-ca-jdk11.0.22-linux_x64 ;    NEO4J_HOME=$_neo4jHm JAVA_HOME=$_java11Hm    PATH=$PATH:$_java11Hm/bin  $_neo4jHm/bin/neo4j'
#qemu8Thread2 端口 4474、4687
neo4j_inst_new 2 && \
alias neo4j_alias_qemu8Thread2='_neo4jHm=/app/neo4j-community-4.4.32--qemu8Thread2 ; _java11Hm=/app/zulu11.70.15-ca-jdk11.0.22-linux_x64 ;    NEO4J_HOME=$_neo4jHm JAVA_HOME=$_java11Hm    PATH=$PATH:$_java11Hm/bin  $_neo4jHm/bin/neo4j'
# 激活 cytoscape
alias cytoscape_boot_with_java17='JAVA_HOME=/app/zulu17.48.15-ca-jdk17.0.10-linux_x64/ /app/cytoscape-unix-3.10.2/cytoscape.sh' && \
#启动
# 启动neo4j
which neo4j && { neo4j status ||  neo4j start ; } && { neo4j status && echo "启动neoj4j成功" ;} && \
echo $OkEnvMsg
