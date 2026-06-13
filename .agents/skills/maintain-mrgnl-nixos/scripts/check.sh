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

echo "==> checking Nix syntax"
while IFS= read -r -d '' file; do
  nix-instantiate --parse "$file" >/dev/null
done < <(find . -path "./.git" -prune -o -type f -name "*.nix" -print0)

echo "==> checking Markdown fences"
markdown_failed=0
while IFS= read -r -d '' file; do
  fence_count="$(awk '/^```/{ count++ } END { print count + 0 }' "$file")"
  if ((fence_count % 2 != 0)); then
    echo "$file: unbalanced fenced code blocks" >&2
    markdown_failed=1
  fi
done < <(find . -path "./.git" -prune -o -type f -name "*.md" -print0)
((markdown_failed == 0))

echo "==> checking formatting"
nix fmt --accept-flake-config -- --ci

echo "==> checking flake outputs"
nix flake check --accept-flake-config

echo "==> dry-building $host"
nixos-rebuild dry-build --flake ".#$host" --accept-flake-config

echo "==> validating generated desktop configuration"
home_generation="$(
  nix build \
    --no-link \
    --print-out-paths \
    ".#nixosConfigurations.${host}.config.home-manager.users.mrgnl.home.activationPackage" \
    --accept-flake-config
)"
niri_package="$(
  nix build \
    --no-link \
    --print-out-paths \
    ".#nixosConfigurations.${host}.config.programs.niri.package" \
    --accept-flake-config
)"
noctalia_package="$(
  nix build \
    --no-link \
    --print-out-paths \
    ".#nixosConfigurations.${host}.config.home-manager.users.mrgnl.programs.noctalia.package" \
    --accept-flake-config
)"

"$niri_package/bin/niri" validate \
  -c "$home_generation/home-files/.config/niri/config.kdl"
"$noctalia_package/bin/noctalia" config validate \
  "$home_generation/home-files/.config/noctalia"

if [[ "$mode" == "full" ]]; then
  echo "==> building t14"
  nix build .#nixosConfigurations.t14.config.system.build.toplevel \
    --no-link \
    --accept-flake-config

  echo "==> building i5-4060ti"
  nix build .#nixosConfigurations.i5-4060ti.config.system.build.toplevel \
    --no-link \
    --accept-flake-config
fi

echo "==> checking patch whitespace"
git diff --check

echo "checks passed"
