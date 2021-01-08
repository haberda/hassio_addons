FROM bbernhard/signal-cli-rest-api:0.31

RUN mkdir -p /data/data

RUN sed -i "s|/home/.local/share/signal-cli|/data/data|g" /entrypoint.sh

CMD ["-signal-cli-config", "/data/"]

VOLUME [ "/ssl", "/data"]
