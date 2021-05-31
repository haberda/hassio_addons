# 0.39
- Updated to latest upstream
## Possible breaking change
The upstream project signal-cli released a new verion (0.8.3), in this new version some older configurations are no longer supported if you are using native mode. After you update send a test message, if it doesn't work with native mode you can:

1. Stop using native mode (set to 0)
2. Roll back to 0.37.2 and never update again (not recommended)
3. Completely delete the data storage by uninstalling the add-on and starting fresh. This requires you to register your number again and recreating groups.

If you don't use native mode then this should not apply to you.
# 0.38
- Updated to latest upstream
- Added option to auto receive messages once per day as per [this recommendation](https://github.com/bbernhard/signal-cli-rest-api#auto-receive-schedule).
# 0.37.2
- Fixed Supervisor cleanup of old images
- Added option for [Native support](https://github.com/bbernhard/signal-cli-rest-api#native-image-experimental) (do not use on arm64)
# 0.37.1
- Disable native mode due to issues with arm64
# 0.37
- Update to latest upstream
- Enable experimental native mode
# 0.36.3
## Potential breaking change, see README
- Move to docker hub
# 0.36.2
- Remove unnessary mappings
- Clear /tmp to save space
# 0.36.1
- Fix /data permissions
# 0.36
- Fix dependency problem in 0.35
# Release 0.34 rollback
- Dependency problems for some users in version 0.35, rolling back to 0.34
# Release 0.35
- Update to latest [upstream](https://github.com/bbernhard/signal-cli-rest-api/releases/tag/0.35) 0.35
# Release 0.34
- Update to latest [upstream](https://github.com/bbernhard/signal-cli-rest-api/releases/tag/0.34) 0.34
# Release 0.32
- Update to latest [upstream](https://github.com/bbernhard/signal-cli-rest-api/releases/tag/0.32) 0.32
- Match versioning of upstream
# Signal-CLI to Rest-API for Home Assistant 0.9
- Update to latest upstream container 0.31
# Signal-CLI to Rest-API for Home Assistant 0.8
- Set the upstream container to known working container rather than rolling release
