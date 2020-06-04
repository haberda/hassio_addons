ARG BUILD_FROM

FROM ${BUILD_FROM}

ENV XDG_DATA_HOME="/data" \
XDG_CONFIG_HOME="/data"

# modify/copy files

RUN sed -i "s|config|data|g" /etc/cont-init.d/*

RUN sed -i "s|config|data|g" /etc/services.d/sickchill/*

VOLUME ["/share", "/ssl", "/data"]
