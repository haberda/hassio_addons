[![Signal logo](logo.png)](https://www.signal.org/)

# Signal Messenger

Send and receive Signal messages with Home Assistant using this add-on, which packages [Signal CLI REST API](https://github.com/bbernhard/signal-cli-rest-api).

## Quick start

1. Add the [production repository](https://github.com/haberda/hassio_addons) to the Home Assistant app/add-on store and install **Signal Messenger**.
2. Choose your options and start the add-on. For continuous receiving, we recommend `json-rpc`; `json-rpc-native` is the native alternative.
3. Install the companion [Signal Messenger REST integration](https://github.com/haberda/signal-integration), then select the running add-on and link or select your Signal account.

You can also select **Open Web UI** on the add-on to link an account, manage groups and devices, and send test messages. The management interface is available only through Home Assistant ingress, with dark mode by default and an optional light theme. It works alongside the integration without consuming incoming messages.

The companion integration provides UI-based setup, notification entities, incoming-message automation events, reactions, alert acknowledgements, and optional Assist conversations. See the [setup and configuration guide](DOCS.md) for installation details and receiving permissions.

If you enable integration receiving in `normal` or `native` mode, disable the add-on's `AUTO_RECEIVE` option to avoid competing receivers.

## Documentation and security

Read [DOCS.md](DOCS.md) for configuration, networking, troubleshooting, and security guidance. The REST API has no built-in authentication: keep it on a trusted network and do not expose its port to the internet.

For direct API usage, see the [upstream API reference](https://bbernhard.github.io/signal-cli-rest-api/). Home Assistant's [built-in Signal Messenger integration](https://www.home-assistant.io/integrations/signal_messenger/) remains an alternative for sending notifications.

The upstream REST API is developed by [bbernhard and contributors](https://github.com/bbernhard/signal-cli-rest-api); this project packages it for Home Assistant.

## AI assistance

AI was used to maintain and improve this existing add-on. The management web interface and its supporting implementation were generated entirely with AI assistance.
