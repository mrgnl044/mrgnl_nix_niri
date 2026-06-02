# Install on the Current Machine

This guide is for the current `t14` host.

## 1. Go to the config

```sh
cd /etc/nixos
```

## 2. Check formatting

```sh
nix fmt -- --ci
```

If it changes files, inspect the diff before committing.

## 3. Check the flake

```sh
nix flake check --no-build --no-write-lock-file --accept-flake-config
```

This evaluates all flake outputs, including `t14` and `i5-5060`.

## 4. Dry build the current host

```sh
nixos-rebuild dry-build --flake .#t14 --accept-flake-config
```

This checks the NixOS build without activating it.

## 5. Validate current Niri config

```sh
niri validate -c ~/.config/niri/config.kdl
```

## 6. Switch

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

## 7. Check failed services

```sh
systemctl --failed
systemctl status home-manager-mrgnl.service
```

If Home Manager fails because of an existing file, make that file explicitly
managed in Home Manager. Do not wipe the whole `~/.config` directory.

## 8. Push after a good switch

```sh
git status --short --branch
git push -u origin main
```
