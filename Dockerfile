FROM docker.io/alpine:latest as build

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
    apk update &&\
    apk add tzdata &&\
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    echo "Asia/Shanghai" > /etc/timezone

ARG V2RAY_VERSION=4.39.2
ENV PATH=$PATH:/opt/v2ray
RUN wget -O v2ray-linux-64.zip https://github.com/v2fly/v2ray-core/releases/download/v${V2RAY_VERSION}/v2ray-linux-64.zip && unzip v2ray-linux-64.zip -d /opt/v2ray && rm -f v2ray-linux-64.zip

CMD v2ray -config=/opt/v2ray/config.json
