# Gruvbox Niri NixOS

Personal NixOS flake for a Gruvbox-dark Wayland desktop built around Niri,
Noctalia, Home Manager, and a terminal-first workflow.

The repository is structured for more than one machine. The current host is
`t14`; `i5-5060` is prepared as a future Intel i5 + NVIDIA RTX 5060 desktop
profile.

## Screenshots

Add screenshots here after the system is switched:

```text
docs/screenshots/desktop.png
docs/screenshots/terminal.png
docs/screenshots/yazi.png
docs/screenshots/noctalia.png
```

Suggested layout:

| Desktop | Terminal |
| --- | --- |
| ![Desktop](docs/screenshots/desktop.png) | ![Terminal](docs/screenshots/terminal.png) |

| Yazi | Noctalia |
| --- | --- |
| ![Yazi](docs/screenshots/yazi.png) | ![Noctalia](docs/screenshots/noctalia.png) |

## What Is Included

- NixOS flake with generated multi-host `nixosConfigurations`.
- Home Manager user layer for `mrgnl`.
- Niri Wayland session.
- Noctalia shell integration.
- Gruvbox-dark GTK, terminal, btop, yazi, fzf, and editor-adjacent theme setup.
- Kitty, fish, starship, tmux, yazi, btop, git/delta, fzf, zoxide.
- Telegram Desktop and a small practical GUI set.
- AmneziaWG config hook through `/etc/amnezia/awg0.conf`.
- Prepared Intel + NVIDIA host profile for a future RTX 5060 machine.
- Flake formatter through `nixfmt-tree`.

## Hosts

Current flake hosts:

```sh
nix flake show
```

- `t14` - current ThinkPad host.
- `i5-5060` - future Intel i5 + RTX 5060 host template.

Use `t14` on the current laptop:

```sh
sudo nixos-rebuild switch --flake /etc/nixos#t14 --accept-flake-config
```

Use `i5-5060` only after generating real hardware config for that machine.

## Repository Map

Read the repository from the top down:

1. `flake.nix` defines inputs, formatter, host registry, and `nixosConfigurations`.
2. `lib/mk-host.nix` attaches Home Manager to every host.
3. `host/<name>/configuration.nix` selects machine-specific layers.
4. `modules/profiles` combines reusable system layers.
5. `modules/*` defines NixOS system behavior.
6. `home/mrgnl.nix` is the Home Manager entrypoint.
7. `home/profiles` selects user layers.
8. `home/programs` configures user applications and dotfiles.
9. `home/packages` installs daily user CLI tools.

More detail:

- [docs/structure.md](docs/structure.md)
- [docs/checks.md](docs/checks.md)
- [docs/install-current.md](docs/install-current.md)
- [docs/migrate-i5-5060.md](docs/migrate-i5-5060.md)

## Checks

Run before switching or committing:

```sh
nix fmt -- --ci
nix flake check --no-build --no-write-lock-file --accept-flake-config
nixos-rebuild dry-build --flake /etc/nixos#t14 --accept-flake-config
niri validate -c ~/.config/niri/config.kdl
```

## Current Install

For the current machine:

```sh
cd /etc/nixos
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

If Home Manager reports an existing unmanaged file, fix that specific file
declaratively instead of deleting random config directories.

## Future RTX 5060 Install

Use the migration guide:

[docs/migrate-i5-5060.md](docs/migrate-i5-5060.md)

The important rule for the new machine: copy VPN secrets manually, start and
verify VPN once during installation, generate real hardware config, then switch
the `i5-5060` host.
