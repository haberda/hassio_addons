FROM emby/embyserver
MAINTAINER Daniel Haber

# Create config folders
RUN mkdir -p /share/.config/emby

COPY run /etc/services.d/emby-server

RUN ["chmod", "+x", "/etc/services.d/emby-server/run"]

VOLUME ["/share", "/ssl"]
