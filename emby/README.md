[![logo](https://github.com/haberda/hassio_addons/blob/master/emby/logo.png)](http://emby.media/)

# Emby

Emby docker container

# What is Emby?

Emby Server automatically streams (and converts, if needed) your media
on-the-fly to play on any device.

# How to use this image

When started the emby web inteface will listen on port 8096 in the container.

# Use

Start the add-on, resourceses will be avaliable in /share. The config files are stored in the /share/.config/emby folder. Your media should reside in the /share folder somewhere. You can migrate an existing instance of emby by copying the config to the above folder and rebuilding your library. You should retain all watched/unwatched data.

Based on emby/embyserver docker image
