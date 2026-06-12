# Checks

## Normal change

Run from `/etc/nixos`:

```sh
nix fmt --accept-flake-config -- --ci
nix flake check --accept-flake-config
nixos-rebuild dry-build --flake .#t14 --accept-flake-config
git diff --check
```

Equivalent project wrapper:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh quick t14
```

## Shared or structural change

For flake inputs, profiles, shared modules, Home Manager wiring, desktop
infrastructure, or host definitions, build both hosts:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh full t14
```

This builds `t14` and `i5-5060` without activating them.

## After switch

```sh
systemctl --failed
systemctl --user --failed
systemctl status home-manager-mrgnl.service
niri validate -c ~/.config/niri/config.kdl
noctalia config validate ~/.config/noctalia
```

For VPN changes:

```sh
systemctl status wg-quick-awg0.service
ip addr show awg0
```

Warnings about the Noctalia substituter being untrusted disappear after the
Nix settings in `modules/core/nix.nix` are active. Passing
`--accept-flake-config` is still required for repository-local flake settings.
