# Signal Messenger add-on for Home Assistant

This add-on allows you to send messages via Signal Messenger to recipients who have the Signal Messenger application installed on their devices.

## Installation

- Add this repository to the Home Assistant Supervisor Add-on Store
- Click install
- Choose your desired port
- Choose your desired options
- Click Start

## Use

Instructions for use can be found in the official [docs](https://www.home-assistant.io/integrations/signal_messenger/).

## Options

### Mode

This option allows you to set the MODE environment variable. This replaces the Use Native variable and adds an additional mode.

Valid options:

- 'normal': Every REST API request invokes the signal-cli JAVA application (slowest mode)
- 'native': Every REST API request invokes a compiled native image (faster than the normal mode)
- 'json-rpc': The signal-cli JAVA application is started once and the REST API wrapper communicates via JSON-RPC with it (slow startup time, but once the Java application is running, it should be the fastest)

### Auto receive

This option is recommened by the up-stream project to be enabled if you do not have a rest api endpoint setup to listen for new messages. See documentation [here](https://github.com/bbernhard/signal-cli-rest-api#auto-receive-schedule) for more details. This option does not apply to json-rpc mode and will be ignored in that mode.

Valid options:

- `off`: Disable Auto receive
- `on`: Enable Auto receive (default)

### SIGNAL-CLI Command Timeout

This option sets the time in seconds to wait before timing out the signal cli command. This option does not apply to json-rpc mode and will be ignored in that mode.(default: 60s)

### Reset data

This option deletes all data and resets the add-on. Be aware all your settings will be destroyed.

## Versioning

This add-on follows the versioning of the upstream container. There is very little difference between this add-on and the container found [here](https://github.com/bbernhard/signal-cli-rest-api).
As of this writing the upstream container versioning uses the 0.xx pattern for releases. This add-on follows the same pattern, but uses 0.xx.y where y indicates a change from the upstream that is related to Home Assistant add-on specific changes.

## Differences with the Upstream

The primary difference between this add-on and the upstream is that the location of the persistent storage has been changed from: `/home/.local/share/signal-cli` to: `/data`.
There is also a script that runs to allow for setting the above option(s).

## Bug Reporting

Bug reports can be filed either with the [add-on repository](https://github.com/TheBlackMini/hassio_addons), or with the [upstream repository](https://github.com/bbernhard/signal-cli-rest-api). 
Please attempt to determine if your bug is related to add-on specific issues, or application issues before filing your report. Add-on specific issues should be submitted to the add-on repository, application specific issues should be filed with the upstream repository.


