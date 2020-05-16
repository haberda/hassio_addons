FROM bbernhard/signal-cli-rest-api:latest

RUN mkdir -p /share/.config/signal-cli

RUN rm -r /home/.local/share/signal-cli

RUN ["ln", "-dsf", "/share/.config/signal-cli", "/home/.local/share/signal-cli"]

ENTRYPOINT ["main"]

VOLUME ["/share", "/ssl", "/home/.local/share/"]
