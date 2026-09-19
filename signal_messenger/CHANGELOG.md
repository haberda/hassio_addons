## New features
- Added json-rpc-native mode.
- Added configurable default message formatting: normal or styled.
- Added configurable API logging: debug, info, warn, or error.
- Added JSON-RPC identity-trust settings and options to skip downloading attachments, stories, avatars, and stickers.
## Fixes and improvements
- Fixed AUTO_RECEIVE so disabling it actually disables scheduled receiving.
- Fixed handling of empty command timeouts.
- Corrected the default mode to normal.
- Updated the persistent-storage mapping from addon_config to app_config, addressing Supervisor’s legacy-mapping warning. Signal data remains at /config.
- Fixed Docker builds to honor BUILD_FROM from the build configuration.
- Improved startup process handoff and removed package-manager caches from the resulting image.
- Re-enabled stricter build and configuration validation.
## Compatibility
- Removed armv7 support. Supported architectures are now amd64 and aarch64.
- Upstream Signal CLI REST API remains at 0.100.