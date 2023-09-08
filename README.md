# .system

This repository contains my NixOS system configuration.

It might look like I know what I'm doing, but this repository has been stitched
together from examples I've found online.

## Installing this OS

```
  |- sudo nixos-rebuild boot --flake .#$machine
```

(where `$machine` is the machine name - e.g. `home-pc`).

## Architecture

Because maybe you're curious why this is structured like this. Or maybe you're
me coming back after a few months without updating this config.

Roughly:

- `machines` represent physical machines this OS is installed on. A `machione`
  couples a (possibly customised) `hardware-scan` result, with any custom
  configuration that particular machine requires. Each `machine` has a `role`.
- `roles` represent the way a particular machine is used. e.g. a `home` role
  might not install the Slack desktop app, while a `work` role might skip
  software needed for hobbyist game-dev. Each `role` has multiple `profiles`.
- `profiles` represent behaviours you want a particular OS install to exhibit.
  e.g. you might want a specific `application` installed in a specific way, or
  you might want to make sure a certain set of dotfiles are available in a
  certain location, or use grub to dual-boot with Windows for gaming purposes.
- `modules` are libraries which can be used to extract common patterns or build
  abstractions.
- `overlays` can be used to provide additional or overriden packages on top of
  Nixpkgs. Ideally this isn't too necessary as each likely requires some degree
  of maintenance.

Currently `roles` decide the hostname. It probably makes more sense for a
`machine` to set the hostname, while a `role` is named in a more domain-specific
way.
