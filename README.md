# baka

## What is it?

Prototypical restic wrapper to be used on my servers. Inspired by Gentoo OpenRC init scripts.

## Installation

Place everything in /opt/baka.

## Configuration

Usage pattern is similar to Gentoo OpenRC init scripts. Edit parameters for specific script in `conf.d/script_name`.

If you need to run the script multiple times with different parameters, copy `conf.d/script_name` to `conf.d/script_name.suffix` and symlink `module.d/script_name` to `module.d/script_name.suffix`, then set the parameters `conf.d/script_name.suffix`.

Scripts named `module.d/script_name.suffix` source parameters from both `conf.d/script_name` then `conf.d/script_name.suffix` whereas `module.d/script_name` only source parameters from `conf.d/script_name`.

## Backup profiles

Nothing is implemented yet. Idea is to make multiple "profiles" with individual restic parameters and multiple modules specified to run.

Something like this:
```
# profiles.d/daily.profile

RESTIC_PASSWORD="0000"
RESTIC_REPOSITORY="/var/backups"

# I miss pre-systemd Arch btw 🥲
MODULES=(filesystem @docker-exec.my-container @mysqldump-local)
```

## Backup restoration

This is out of scope. Idea is to automate restic backups, not the whole restic.
