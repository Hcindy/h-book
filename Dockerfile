# 用于gitlab-ci时的镜像
# docker build -t git .

FROM alpine:3.13.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add git
