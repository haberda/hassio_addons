## Update upstream
- Update to 0.81 upstream fixing broken functionality

## Add-on related updates
- Move config storage to new addon_configs storrage. The user now has direct access to the config files.
- Changed the add-on startup to a service. This means it will still start before Home Assistant but after critical services like databases.