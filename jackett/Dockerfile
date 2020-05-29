FROM linuxserver/jackett

ENV XDG_DATA_HOME="/data" \
XDG_CONFIG_HOME="/data"

# modify/copy files

RUN sed -i "s|config|data|g" /etc/cont-init.d/*

VOLUME ["/share", "/ssl", "/data"]
