---
name: maintain-mrgnl-nixos
description: Maintain the mrgnl NixOS flake in /etc/nixos. Use for any repository change involving NixOS modules, Home Manager, hosts, packages, Niri, Noctalia, Gruvbox theming, VPN wiring, NVIDIA migration, documentation, rebuilds, activation failures, or project structure.
---

# Maintain mrgnl NixOS

Work from `/etc/nixos` and treat the repository as the source of truth for both
the system and the `mrgnl` user environment.

## Start With Context

1. Run `git status --short --branch`.
2. Read the files on the relevant import path before editing.
3. Read [references/project-map.md](references/project-map.md) for ownership,
   host boundaries, or structural changes.
4. Read [references/validation.md](references/validation.md) before applying,
   committing, or diagnosing a failed activation.

Do not overwrite unrelated user changes in a dirty worktree.

## Choose The Correct Layer

- Put machine identity and hardware imports in `host/<name>/`.
- Combine reusable system behavior in `modules/profiles/`.
- Put NixOS services, hardware, users, and recovery tools in `modules/`.
- Put user packages and generated dotfiles in `home/`.
- Put shared Gruvbox values in `home/common/colors.nix`.
- Put public guidance in `README.md` or `docs/`, not in Nix comments.

Prefer extending an existing category over creating a new abstraction. Split a
file when it owns more than one clear concern or becomes difficult to scan.

## Preserve Architecture

- Keep `nixpkgs` and Home Manager on matching release lines.
- Register hosts in `flake.nix`; attach Home Manager only through
  `lib/mk-host.nix`.
- Keep host files small: hardware, profiles, hostname, and state version.
- Install root/recovery tools with `environment.systemPackages`.
- Install daily user tools with `home.packages` or `programs.<name>`.
- Let Home Manager own managed dotfiles. Use `force = true` only for a known
  collision, not as a blanket workaround.
- Let Niri start Noctalia. Do not also enable its systemd startup.
- Configure the Noctalia bar under `bar.default`; do not introduce a second bar
  name without an explicit multi-monitor design.
- Keep secrets out of Git. The AmneziaWG secret remains
  `/etc/amnezia/awg0.conf`.
- Never switch `i5-5060` on the ThinkPad. Build it only as a migration check.
- Require a real generated hardware configuration before installing
  `i5-5060`.

## Implement Changes

1. Make the smallest coherent edit in the owning module.
2. Reuse existing imports, naming, Gruvbox tokens, and file layout.
3. Update documentation when commands, paths, hosts, or ownership change.
4. Avoid duplicate packages and duplicate runtime ownership.
5. Keep commits scoped and use lowercase imperative English, for example:
   `add project maintenance skill` or `fix noctalia bar ownership`.

## Validate Changes

Run the bundled checker from the repository root:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh quick t14
```

Use `full` for shared modules, flake inputs, profiles, Home Manager wiring,
desktop infrastructure, or host changes:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh full t14
```

Add the component-specific checks from
[references/validation.md](references/validation.md). A successful build does
not replace runtime checks after `switch`.

## Apply Carefully

Apply the current laptop only after checks pass:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

Then check failed system and user units. If Home Manager reports a collision,
inspect the exact path and its `.hm-backup`; do not delete broad config
directories.
