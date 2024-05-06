#!/bin/bash

#【描述】  bash的rcfile
#【依赖】   
#【术语】 
#【备注】 

enterEnvMsg="fridaAnlzAp环境"
OkEnvMsg="fridaAnlzAp环境 ok: [Miniconda3, neo4j-community, cytoscape]"

echo $enterEnvMsg && \
source /app/Miniconda3-py310_22.11.1-1/bin/activate && \
source /app/nvm/nvm.sh && \
export NEO4J_HOME=/app/neo4j-community-4.4.32 && \
export JAVA_HOME=/app/zulu11.70.15-ca-jdk11.0.22-linux_x64 && \
export PATH=$PATH:$NEO4J_HOME/bin:$JAVA_HOME/bin && \
echo $OkEnvMsg
