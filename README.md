# Ubuntu setup for development

Run the installer:

`sudo bash setup.sh`

## Group of roles

Everything is grouped in the following roles:

* Design: Collection of design tools.
* Development: Everything related to my development workflow; editor, configs, libraries, database clients,
  profilers, etc.
* Games: Basically, nethack and gtypist.
* Hardware: Peripherals support.
* Productivity: Collection of tools for the day-to-day office duties. Communication, text formatters, music
  players, etc.
* Security: Security and backup configurations.
* Ubuntu: Extensions and configurations.

## Customization

* `group_vars/all`: Specify the binary versions, repositories and local username.
* `vars/roles`: Select which roles will be installed.
