# Major changes:
- Change to php8 base image, this comes with a dramatic speed increase
- Update to latest s6overlay
- Change how folder mappings are done in the container to reduce long term burden

# Possible breaking changes
- Folder mapping has changed, it's possible it could break your install, make a backup before updating!
- Update to php8 shouldn't break anything, but who knows?