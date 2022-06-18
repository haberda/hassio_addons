# Emby add-on for Home Assistant

This add-on allows you to play media to many devices.

## Installation

- Add this repository to the Home Assistant Supervisor Add-on Store
- Click install
- Choose your desired port
- Choose your desired options
- Click Start

## Use

Instructions for use can be found in the official [docs](https://support.emby.media/support/solutions/articles/44001159034-quick-start).

## Options

### networkdisks

This option lets you set a list of network shares to mount in the container. They will be mounted in the container at the same path as the share. For example: a NAS share at `//nas/share1/` will be mounted in the container at `/nas/share1/`.

### cifsusername

The username that has access to all listed shares.

### cifspassword

The password to the listed shares for the username specified.

### cifsversion

The version of samba to use. Unless you have a reason, leave it at 3.0.

## Example configuration

```
networkdisks:
  - //nas/share1
  - //nas/share2
cifsusername: yourUsername
cifspassword: yourPassword
cifsversion: '3.0'

```

## Versioning

This add-on follows the versioning of the upstream project; this is so that you know what verson of the software the container is running.

## Bug Reporting

Bug reports can be filed either with the [add-on repository](https://github.com/haberda/hassio_addons), or with the [upstream repository](https://github.com/bbernhard/signal-cli-rest-api). 
Please attempt to determine if your bug is related to add-on specific issues, or application issues before filing your report. Add-on specific issues should be submitted to the add-on repository, application specific issues should be filed with the upstream repository.


