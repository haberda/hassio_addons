ARG BUILD_FROM

FROM ${BUILD_FROM}

RUN sed -i "s|config|data|g" /etc/services.d/emby-server/run

VOLUME ["/share", "/ssl", "/data"]
