ARG BUILD_FROM

FROM "dlandon/zoneminder"

# modify/copy files

ENV TZ="America/Los_Angles"

ENV INSTALL_HOOK="1"

ENV INSTALL_FACE="1"

ENV INSTALL_TINY_YOLO="1"

ENV INSTALL_YOLO="1"

RUN sed -i "s|config|data|g" /etc/my_init.d/*

RUN sed -i "s|/var/cache/zoneminder|/data/data|g" /etc/my_init.d/*

RUN echo "/usr/share/zoneminder/www /var/www/html auto bind,defaults 0 0" >> /etc/fstab

RUN ["ln", "-s", "/var/cache/zoneminder/cache", "/usr/share/zoneminder/www/cache"]

VOLUME ["/share", "/ssl", "/data", "media"]
