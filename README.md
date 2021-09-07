# Ubuntu setup for development

Run the installer:

`bash setup.sh`

## Group of roles

Everything is grouped in the following roles:

* Development: Everything related to my development workflow; editor, configs, libraries, database clients,
  profilers, etc.
* Productivity: Collection of tools for the day-to-day office duties. Communication, text formatters, music
  players, etc.
* Security: Security and backup configurations.
* Desktop: Extensions and configurations on the operating system.

## Customization

* `group_vars/all`: Specify the binary versions and some repositories.
* `vars/roles`: Select which roles will be installed.
