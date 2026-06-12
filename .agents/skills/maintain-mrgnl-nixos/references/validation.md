# Validation Matrix

## Standard Sequence

Run from `/etc/nixos`:

```sh
nix fmt --accept-flake-config -- --ci
nix flake check --accept-flake-config
nixos-rebuild dry-build --flake .#t14 --accept-flake-config
```

Use the bundled wrapper for the same sequence:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh quick t14
```

## Full Cross-Host Check

Required after changing shared modules, profiles, Home Manager wiring, flake
inputs, desktop infrastructure, or host definitions:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh full t14
```

This builds both `t14` and `i5-5060` without activating either.

## Component Checks

| Changed area | Additional check |
| --- | --- |
| Active Niri KDL | `niri validate -c ~/.config/niri/config.kdl` after switch |
| Active Noctalia config | `noctalia config validate ~/.config/noctalia` after switch |
| Home Manager | `systemctl status home-manager-mrgnl.service` |
| System services | `systemctl --failed` |
| User services | `systemctl --user --failed` |
| Current boot errors | `journalctl -b -p err --no-pager` |
| User session errors | `journalctl --user -b -p err --no-pager` |
| VPN | `systemctl status wg-quick-awg0.service` and `ip addr show awg0` |

For generated Niri changes, a full system build proves the files are generated
but does not parse KDL. Validate the active config after switching, or render the
Home Manager files to a temporary directory and run `niri validate` there.

## Activation Rules

Switch only the machine currently in use:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

Do not switch `i5-5060` on `t14`.

## Home Manager Collisions

When activation reports an existing file:

1. Read the exact source and destination path.
2. Check for an existing `.hm-backup`.
3. Move or remove only the stale backup when it is confirmed safe.
4. Prefer declaring the file through Home Manager.
5. Use `force = true` only on the specific managed file when replacement is
   intentional.

Never delete all of `~/.config`.

## Commit Gate

Before committing:

```sh
git diff --check
git status --short
```

Use lowercase imperative English:

```text
add project maintenance skill
fix noctalia bar ownership
document desktop migration
```
