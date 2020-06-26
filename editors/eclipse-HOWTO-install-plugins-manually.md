# Manually Installing Eclipse Plugins

Ref: https://wiki.eclipse.org/Equinox/p2/Getting_Started#Dropins

- Single jar - drop *jar* in `<eclipse>/dropins/`
- Multiple jars - drop *directory* in `<eclipse>/dropins/`
  - `<eclipse>/dropins/<plugin_name>/` should have only 2 directories - `features/` and `plugins/`
  - Any files or dirs other than `features/` and `plugins/` should be deleted
