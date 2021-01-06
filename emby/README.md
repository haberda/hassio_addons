[![](https://github.com/haberda/hassio_addons/blob/master/emby/logo.png)](http://emby.media/)

# Emby

An Emby Mediaserver Home Assistant add-on.

# What is Emby?

Emby Mediaserver automatically streams (and transcodes, if needed) your media
on-the-fly to play on any device.

# How to use this add-on

When started the emby web inteface will listen on port 8096 in the container and 8096 by default on the host.

Place your media in /share. The config files are stored in the /data folder and will be backed up with a shapshot. You can migrate an existing instance of emby by copying the config to the add-on data folder if you have access, or you can use emby's built in config backup/restore feature.

Based on emby/embyserver docker image
