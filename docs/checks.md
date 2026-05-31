# Checks

Run these before switching or committing:

```sh
nix fmt -- --ci
nix flake check --no-build --no-write-lock-file --accept-flake-config
nixos-rebuild dry-build --flake /etc/nixos#t14 --accept-flake-config
niri validate -c ~/.config/niri/config.kdl
```

If Nix warns that the Noctalia substituter is untrusted, rebuild once after `modules/core/nix.nix` has been applied. The config trusts `@wheel`, so regular user checks can use the Cachix settings after activation.
