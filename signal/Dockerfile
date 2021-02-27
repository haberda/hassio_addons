FROM bbernhard/signal-cli-rest-api:0.36

WORKDIR /data/data/

RUN sed -i "s|/home/.local/share/signal-cli|/data|g" /entrypoint.sh

CMD ["-signal-cli-config", "/data/"]

VOLUME [ "/ssl", "/data"]
