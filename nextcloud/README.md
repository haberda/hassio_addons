[![](logo.png)](https://nextcloud.com/)

# Nextcloud

Nextcloud Home Assistant add-on

# How to use this add-on

Install the add-on, choose your desired port, start.

After the add-on is started proceed to: https://[ip]:[port] and follow the setup process.

# How to add trusted domain
Nextcloud requires a whitelist of trusted domains in order to access Nextcloud externally, or even internally from an address that is different from the domain it is initially assessed from. Normally this requires editing of a config file. If you have access to the add-on data storage (i.e. Supervised Installation) then the recommended method is to follow official documentation to add your domain. 

If you are running HASSOS and have no access to edit this file you can add your domain from the add-on [SSH & Web Terminal](https://github.com/hassio-addons/addon-ssh) via the command line. To do this, you must turn off the 'Protection Mode' of the SSH & Web Terminal add-on.

Launch both the Nextcloud and SSH & Web Terminal add-ons. Enter the web interface of the SSH & Web Terminal add-on. Once there, type:

> docker ps | grep nextcloud

If you see something like this:

> 1881ce17ba8c   ghcr.io/haberda/nextcloud/amd64:d4973ba                       "/init"                  13 days ago     Up 13 days             80/tcp, 0.0.0.0:8099->443/tcp, :::8099->443/tcp                                                                                                                                                                                                                            addon_1315902c_nextcloud

To enter the add-on console enter:

> docker exec -it addon_1315902c_nextcloud bash

This should put you in the root of the add-on. config.php is located here:

> /data/config/www/nextcloud/config

Once you navagate there just follow the [docs](https://help.nextcloud.com/t/howto-add-a-new-trusted-domain/26). You can use the nano file editor:

> nano config.php

# Data directory

The default location for user data is set to `/data`. This is fine, but will make backups of the add-on very large with time. I recommend on initial install changing it to `/share/nextcloud` so that your user data can live somewhere different that the Nextcloud install. Once the two are fused, they can be difficult to disentangle.

Based on the [linuxserver](https://hub.docker.com/r/linuxserver/nextcloud) image
