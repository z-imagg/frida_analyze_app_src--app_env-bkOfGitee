#!/usr/bin/bash

#【描述】  neo4j-4.4.32 尝试启动
#【依赖】   
#【术语】 
#【备注】   

#'-e': 任一语句异常将导致此脚本终止; '-u': 使用未声明变量将导致异常
set -e -u

#导入配置
source $pdir/docker_instance.sh

#jdk11 
export JAVA_HOME=/app/zulu11.70.15-ca-jdk11.0.22-linux_x64 && \
#neo4j-4.4.32
export NEO4J_HOME=/app/neo4j-community-4.4.32 && \
export PATH=$PATH:$NEO4J_HOME/bin:$JAVA_HOME/bin && \
which javac && which java && which neo4j && \
#neo4j配置为 监听0.0.0.0 、 4个工作线程
neo4j --help && \
# neo4j 4.4.32
neo4j version && \
F_cfg=/app/neo4j-community-4.4.32/conf/neo4j.conf && \
grep dbms.default_listen_address $F_cfg && \
grep dbms.memory $F_cfg && \
cp -v $F_cfg "${F_cfg}_$(date +%s)" && \
#修改 neo4j 监听地址为0.0.0.0
sed -i  "s/#dbms.default_listen_address=0.0.0.0/dbms.default_listen_address=0.0.0.0/g"  $F_cfg && \
#修改 neo4j 线程数目为 4 
sed -i  's/#dbms.threads.worker_count=/dbms.threads.worker_count=4/'   $F_cfg && \
echo $msg1 && \
true