
#【术语】 #dk# == #docker# == 仅docker有,  #sh# == #bash# == 仅bash有, #dksh# == #docker_shell# == docker有、bash有 
#【备注】 在bash中 冒号':' 表示 空指令

FROM ubuntu:22.04 as base
WORKDIR /


LABEL maintainer="test <test@163.com>"
LABEL version="0.1"
LABEL description="test "


#不指定ENTRYPOINT、不指定CMD, 
# docker rm demo1 demo2
# docker image rm demo
# docker build --no-cache  -f /app/app_env/x.Dockerfile -t demo /
# # 非交互式例子demo1
# # docker stop demo1; docker rm demo1; 
# # docker run --interactive --tty     --name demo1 demo /bin/bash -c ls /
# # 交互式demo2
# docker stop demo2; docker rm demo2; 
### 启动demo2且启动后保持up状态
# docker run --interactive --tty --detach      --name demo2 demo /bin/bash
# docker exec   demo2 /bin/bash  -c ls /
### 日常使用demo2
# docker exec --interactive --tty demo2 bash
