#!/usr/bin/env bash

set -euo pipefail

mode="${1:-quick}"
host="${2:-t14}"

case "$mode" in
  quick | full) ;;
  *)
    echo "usage: $0 [quick|full] [host]" >&2
    exit 2
    ;;
esac

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

echo "==> checking formatting"
nix fmt --accept-flake-config -- --ci

echo "==> checking flake outputs"
nix flake check --accept-flake-config

echo "==> dry-building $host"
nixos-rebuild dry-build --flake ".#$host" --accept-flake-config

if [[ "$mode" == "full" ]]; then
  echo "==> building t14"
  nix build .#nixosConfigurations.t14.config.system.build.toplevel \
    --no-link \
    --accept-flake-config

  echo "==> building i5-5060"
  nix build .#nixosConfigurations.i5-5060.config.system.build.toplevel \
    --no-link \
    --accept-flake-config
fi

echo "==> checking patch whitespace"
git diff --check

echo "checks passed"
