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

### Use Native: `native_mode`

This option sets an environment variable in the add-on to use a pre-compiled binary to send messages rather than using the Java application. This reduces the send time from ~15 seconds to ~5 seconds. More information can be found [here](https://github.com/bbernhard/signal-cli-rest-api#native-image-experimental).

Valid options:

- `0`: Disable Native mode (default)
- `1`: Enable Native mode

This currently only works with a 64 bit OS on amd64. arm64 platforms (e.g. Pi4 with 64bit OS) will fail to send messages when this is enabled, and armv7 (e.g. Pi3 with 32bit OS) platforms will ignore this option.

### Auto receive

This option is recommened by the up-stream project to be enabled if you do not have a rest api endpoint setup to listen for new messages. See documentation [here](https://github.com/bbernhard/signal-cli-rest-api#auto-receive-schedule) for more details.

Valid options:

- `0`: Disable Auto receive
- `1`: Enable Auto receive (default)

## Versioning

This add-on follows the versioning of the upstream container. There is very little difference between this add-on and the container found [here](https://github.com/bbernhard/signal-cli-rest-api).
As of this writing the upstream container versioning uses the 0.xx pattern for releases. This add-on follows the same pattern, but uses 0.xx.y where y indicates a change from the upstream that is related to Home Assistant add-on specific changes.

## Differences with the Upstream

The primary difference between this add-on and the upstream is that the location of the persistent storage has been changed from: `/home/.local/share/signal-cli` to: `/data`.
There is also a script that runs to allow for setting the above option(s).

## Bug Reporting

Bug reports can be filed either with the [add-on repository](https://github.com/haberda/hassio_addons), or with the [upstream repository](https://github.com/bbernhard/signal-cli-rest-api). 
Please attempt to determine if your bug is related to add-on specific issues, or application issues before filing your report. Add-on specific issues should be submitted to the add-on repository, application specific issues should be filed with the upstream repository.

