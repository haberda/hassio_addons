[![](logo.png)](https://www.signal.org/)

# Breaking change, Important please read

As of 0.36.3 this add-on has been changed (for the better). In the past this add-on dynamically built from an upstream container.
The advantage of this is the ease of deployment. But there are several important disadvantages, all related to snapshots:

- The snapshot size was large because the entire image needed to be backed up
- The snapshot would not let you roll back most of the time
- If the upstream image (which I do not control) disappears then it breaks

For this and other maintenance reasons I have started building the image prior to release and hosting them on docker hub.

## What does this mean?

Some users are reporting that the new method will not install cleanly over the previous image. If this is your issue for now you can roll back to an earlier snapshot. Ultimately if this is an issue you will need to remove the add-on and reinstall. The implication here is that you will have to 'start from scratch' and register your number and groups again.

You can get around this a number of ways, all of them coming down to backing up and restoring the data folder that the add-on saves to.

### Before you do anything take a Snapshot

## Methods for backing up and restoring the data

If you are on a supervised installation, just navigate to the addons/data folder and copy the folder called: 1315902c_signal_messenger to somewhere safe. Remove the add-on, reinstall, then restore the folder.

If you have no access to the filesystem (e.g. HassOS):

1. Shutdown the system and remove the SD Card
2. Place the SD Card in another system and open: hassos-data/supervisor/addons/data
3. There you will find 1315902c_signal_messenger save the folder somewhere
4. Place the SD Card back in your system and boot up
5. Remove and reinstall the add-on
6. Shut your system down again, then repeat step 2 and restore the 1315902c_signal_messenger folder
7. Reboot system, should be good to go

Another method (tested by @LiJu09 and found to be very [easy](https://github.com/haberda/hassio_addons/issues/25).):

1. Take a snapshot of just the Signal add-on without a password
2. Download to a local computer open the snapshot and find the 'data' folder in the snapshot, copy it somewhere
3. Delete the add-on and reinstall
4. Take a new snapshot of the fresh install and download to the same computer
5. Open the snapshot and replace the 'data' folder with the one from step 2
6. Restore the new Frankenstein snapshot

Sorry for the pain, but this is good for the long term health of the add-on. No need to rush to update, 0.36.1 is still aligned with the upstream latest and pretty much the same as 0.36.3.

This message will remain here for a couple releases, until everyone has updated.

# Signal Messenger

Signal-CLI to Rest-API Home Assistant add-on

# How to use this add-on

Install the add-on, choose your desired port, start.

After the add-on is started follow the directions at the link below starting from "Register phone number"

https://github.com/bbernhard/signal-cli-rest-api/blob/master/doc/HOMEASSISTANT.md

Then proceed here:

https://www.home-assistant.io/integrations/signal_messenger/

# API details

If you want to use i.e. REST to receive messages in HA, you can find more details [here](https://bbernhard.github.io/signal-cli-rest-api/)


All credit to [@bbernhard](https://github.com/bbernhard), all I did was take his [work](https://github.com/bbernhard/signal-cli-rest-api) and make an add-on.
