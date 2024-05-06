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
echo $OkEnvMsg
