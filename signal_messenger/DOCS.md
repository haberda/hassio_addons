# Signal Messenger add-on for Home Assistant

This add-on provides the Signal REST API backend for sending and receiving messages. We recommend the companion [Signal Messenger REST integration](https://github.com/haberda/signal-integration) to connect it to Home Assistant.

## Installation

1. Add `https://github.com/haberda/hassio_addons` to the Home Assistant app/add-on store repositories.
2. Install **Signal Messenger**.
3. Choose your port and options. For continuous receiving, we recommend `json-rpc`; `json-rpc-native` is the native alternative.
4. Start the add-on before configuring the integration.

## Management web interface

Select **Open Web UI** on the add-on's page in Home Assistant. The interface is served only through Home Assistant ingress: port 8099 is not published, and the UI accepts connections only from the ingress gateway. No separate UI password, browser extension, or external website is required. Dark mode is the default; the theme switch supports light mode and saves only that preference in your browser.

The `WEBUI_ENABLED` option controls whether the management interface starts. It defaults to `true`. Set it to `false` if you do not want the web UI; the Signal REST API continues to run for other clients, but **Open Web UI** will be unavailable after the add-on restarts.

### Onboarding and daily use

1. Open **Link an account**, name the linked device, and confirm generation of a QR code. On your phone, use Signal → Settings → Linked devices to scan and approve it. The QR is generated locally, never by an external service.
2. Select **I scanned it — refresh accounts** after approval, then select the account in the header. The QR display expires after five minutes; refreshing accounts does not start another linking handshake. Leaving the page hides the QR but cannot cancel a handshake already started upstream.
3. Open **Test messages** and enter one explicit destination. To send to yourself, use the selected account's number. You can send text, one attachment up to 2 MiB, quoted replies, or edits to a known sent-message timestamp. A successful API response is not proof of delivery or reading.
4. Open **Groups** to create a group or select an existing one. Review members, administrators, pending invitations/requests, and the invite link. Update the name, description, avatar, message timer, link policy, or permissions; add/remove members and administrators; accept your own pending invitation; or leave/block the group. Refresh after mutations to see the current state. Leaving does not delete the group for everyone.
5. Use **Contacts**, **Account & devices**, and **Identity & security** for contact names/timers, profiles, phone-number privacy, usernames, linked devices, registration PINs, verified safety numbers, and rate-limit challenges. Primary-account operations may be unavailable when the backend is linked to a phone.

Advanced onboarding supports SMS/voice registration with optional CAPTCHA and PIN handling. Registration is not the same as linking a phone: it makes the backend a primary device and may replace an existing registration. CAPTCHA must be completed externally; paste the resulting token into the form. Message tools also support reactions, remote deletion, and creating/closing polls.

Every mutation requires review and confirmation. Failed or timed-out requests are never automatically retried because the operation may already have succeeded. Check Signal or refresh backend state before repeating one. Sensitive values and messages are not saved in browser storage or UI request logs. Upstream logging is separate; avoid debug logging when handling sensitive data.

### Scope and upstream limitations

The UI manages Signal state through `http://127.0.0.1:8080`; it does not launch another `signal-cli` process, edit Home Assistant integration settings, or change add-on configuration. The existing REST API port remains separate for integration clients and is not protected by ingress authentication. The UI does not poll or subscribe to incoming messages, so it cannot consume messages intended for the integration.

- Profile updates in upstream 0.100 remove the existing avatar if no image is supplied. The UI requires either an avatar upload or explicit approval to remove it.
- Upstream 0.100 omits a zero group-expiration value from its JSON-RPC update payload. The UI blocks that ambiguous operation in JSON-RPC modes: disable the timer using your phone or temporarily use normal/native mode instead.
- Current values for some settings are not available from the REST API. Optional fields left blank preserve upstream settings rather than assuming defaults.
- CLI-only operations such as phone-number changes, arbitrary group invite-link joining, group ban/unban and link reset, device renaming, and contact block/unblock are not exposed. A second CLI process could contend with the running backend's account storage. Prefer your Signal client until upstream REST support exists.
- Account deletion, local-data deletion, and blanket identity trust are deliberately not exposed.
- This is an administrative surface: anyone who can open its ingress page can manage the backend's Signal accounts. Do not treat the integration's sender allowlists as web UI access control.

## Home Assistant integration

The companion integration is a custom integration, separate from Home Assistant's built-in Signal Messenger integration.

### Setup

1. Check the integration's [requirements and installation instructions](https://github.com/haberda/signal-integration#requirements-and-installation). The currently documented minimum is Home Assistant 2026.9.1.
2. In HACS, add `https://github.com/haberda/signal-integration` as a custom repository of type **Integration**, download **Signal Messenger REST**, and restart Home Assistant. Manual installation instructions are available in the integration repository.
3. Open **Settings → Devices & services → Add integration → Signal Messenger REST**.
4. Select the detected running add-on, or enter a backend URL reachable from Home Assistant.
5. Select an existing Signal account or use the guided QR flow to link your phone. SMS/voice registration remains a backend operation; see the [upstream setup guide](https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/HOMEASSISTANT.md) if needed.
6. Choose notification destinations and optionally enable receiving with explicit sender/group permissions.

On Home Assistant OS/Supervised, discovery uses the add-on's internal hostname and port 8080, independently of the published host port. For a manual connection, use a reachable hostname or host IP and the appropriate port. Do not use `localhost` to connect from Home Assistant to the add-on: they run in separate containers.

### Receiving and automations

- `json-rpc` and `json-rpc-native` use a WebSocket connection. The add-on's `AUTO_RECEIVE` setting is ignored in these modes.
- `normal` and `native` use polling. When integration receiving is enabled, set `AUTO_RECEIVE: false` and stop other receive sensors or helper receivers for the same account. Competing receivers can consume messages before the integration sees them.
- For send-only `normal` or `native` deployments, keep periodic auto receive enabled as recommended upstream.
- An empty incoming sender allowlist permits no incoming message events. Group messages require both an allowed sender and an allowed group.
- Assist has separate permissions; authorizing message events does not automatically authorize Assist commands.

See the integration's [receiving examples](https://github.com/haberda/signal-integration#receiving-and-automations) and [alert acknowledgement guide](https://github.com/haberda/signal-integration#reactions-and-alert-acknowledgment). Its blueprints must be imported or copied separately; HACS does not install them automatically.

Receiving does not provide a durable inbox or guaranteed replay after disconnection. Duplicate suppression and pending alert acknowledgements are held in memory and do not survive an integration reload or Home Assistant restart. Do not use this as the only path for critical alerts.

### Troubleshooting and alternatives

- If connection setup fails, check that the add-on is running and that the URL is reachable from Home Assistant. A reverse proxy must support WebSockets for JSON-RPC receiving.
- If connected but no events arrive, check receiving is enabled and review sender/group permissions. In polling modes, check for competing receivers.
- For integration diagnostics and Assist troubleshooting, see the [integration documentation](https://github.com/haberda/signal-integration#receiving-troubleshooting).

For sending notifications without the companion integration, follow the [built-in Signal Messenger integration documentation](https://www.home-assistant.io/integrations/signal_messenger/). For direct REST access, use the [upstream API reference](https://bbernhard.github.io/signal-cli-rest-api/).

## AI assistance

AI was used to maintain and improve this existing add-on. The management web interface and its supporting implementation were generated entirely with AI assistance.

## Security

This add-on exposes the upstream Signal REST API on its configured port. The API does not provide authentication, so any client that can reach that port can use the linked Signal account, including sending and receiving messages. Run the add-on only on a trusted network, do not expose or port-forward its REST API port to the internet, and use a firewall, VPN, or authenticated reverse proxy if remote access is required.

The companion integration's sender/group allowlists control which incoming messages can reach its events and Assist features; they do not authenticate or protect the REST API itself. Received messages are decrypted in the backend and passed to Home Assistant, where event listeners, automation traces, or configured Assist providers may retain content.

## Options

### Mode

This option allows you to set the MODE environment variable. This replaces the Use Native variable and adds an additional mode.

Valid options:

- 'normal': Every REST API request invokes the signal-cli JAVA application (slowest mode)
- 'native': Every REST API request invokes a compiled native image (faster than the normal mode)
- 'json-rpc': The signal-cli JAVA application is started once and the REST API wrapper communicates via JSON-RPC with it (slow startup time, but once the Java application is running, it should be the fastest)
- 'json-rpc-native': The signal-cli native application is started once and the REST API wrapper communicates via JSON-RPC (fastest mode with lower memory usage)

### Auto receive

Upstream recommends periodic receiving when no other receiver is running. Disable this option when the companion integration or another client receives messages in `normal` or `native` mode. See the [upstream guidance](https://github.com/bbernhard/signal-cli-rest-api#auto-receive-schedule) for details. This option is ignored in `json-rpc` and `json-rpc-native` modes.

Valid options:

- `false`: Disable Auto receive
- `true`: Enable Auto receive (default)

### Default Signal Text Mode

Sets the default text mode for outbound messages. Only comes into play, if `text_mode` is not set for an individual message as part of the request payload.

- `normal`: no formatting options
- `styled`: renders `*italic*`, `**bold**`, `~strikethrough~`

### Log Level

Controls the upstream REST API log verbosity.

- `debug`: detailed diagnostic logging
- `info`: routine operational logging (default)
- `warn`: warnings and errors only
- `error`: errors only

### JSON-RPC Settings

These options apply only to `json-rpc` and `json-rpc-native` modes.

#### Trust New Identities

Controls how Signal identity keys are trusted when they are first encountered.

- `on-first-use`: trust the first identity seen for a recipient (default)
- `always`: automatically trust new or changed identities
- `never`: do not automatically trust identities

#### Ignore Downloaded Media

When enabled, the associated media type is not automatically downloaded when receiving messages. All options default to `false`.

- Ignore attachments
- Ignore stories
- Ignore avatars
- Ignore stickers

### SIGNAL-CLI Command Timeout

This option sets the time in seconds to wait before timing out the signal cli command. This option does not apply to `json-rpc` or `json-rpc-native` mode and will be ignored in those modes. (default: 60s)

## Versioning

This add-on follows the versioning of the upstream container. There is very little difference between this add-on and the container found [here](https://github.com/bbernhard/signal-cli-rest-api).
As of this writing the upstream container versioning uses the 0.xx pattern for releases. This add-on follows the same pattern, but uses 0.xx.y where y indicates a change from the upstream that is related to Home Assistant add-on specific changes.

## Differences with the Upstream

The primary difference between this add-on and the upstream is the location of persistent storage. Signal CLI data is stored in `/config` through the `SIGNAL_CLI_CONFIG_DIR` environment variable, rather than upstream's default `/home/.local/share/signal-cli`. The add-on reads its Home Assistant configuration options separately from `/data/options.json`.
There is also a script that runs to allow for setting the above option(s).

## Bug Reporting

Bug reports can be filed either with the [add-on repository](https://github.com/haberda/hassio_addons), or with the [upstream repository](https://github.com/bbernhard/signal-cli-rest-api).
Please attempt to determine if your bug is related to add-on specific issues, or application issues before filing your report. Add-on specific issues should be submitted to the add-on repository, application specific issues should be filed with the upstream repository.
