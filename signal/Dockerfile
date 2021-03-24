FROM bbernhard/signal-cli-rest-api:0.37

LABEL io.hass.version="0.37.2" io.hass.type="addon" io.hass.arch="armhf|aarch64|amd64"

COPY options.sh /options.sh

RUN apt-get clean \

        && apt-get update \

        && apt-get install -y --no-install-recommends jq

WORKDIR /data/data/

ENTRYPOINT ["/options.sh"]

VOLUME ["/data"]
