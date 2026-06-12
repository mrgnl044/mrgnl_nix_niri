# mrgnl NixOS

Reproducible Gruvbox-dark NixOS configuration built around Niri, Noctalia 5,
Home Manager, and a terminal-first workflow.

The repository currently drives a ThinkPad `t14` and prepares a separate
Intel + NVIDIA RTX 5060 desktop host without mixing their hardware settings.

## Stack

| Layer | Components |
| --- | --- |
| System | NixOS 26.05, flakes, systemd-boot, NetworkManager |
| Desktop | Niri, greetd/tuigreet, Noctalia 5, Wayland |
| Theme | Gruvbox Dark, Inter, JetBrains Mono Nerd Font |
| Terminal | Kitty, Fish, Starship, tmux |
| CLI | Neovim, Micro, Yazi, btop, Git/Delta, fzf, zoxide |
| GUI | Firefox, Nautilus, Telegram, Spotify, Obsidian, Transmission |
| Hardware | Intel graphics on `t14`; Intel + NVIDIA Open on `i5-5060` |
| Network | NetworkManager and declarative AmneziaWG service wiring |

## Hosts

| Host | Status | Purpose |
| --- | --- | --- |
| `t14` | Active | Current ThinkPad installation |
| `i5-5060` | Prepared | Migration target for an Intel desktop with RTX 5060 |

The desktop host can be evaluated and built now, but it must receive a real
generated `hardware-configuration.nix` on the new machine before installation.

## Architecture

```text
flake.nix
├── lib/mk-host.nix                 shared NixOS + Home Manager constructor
├── host/
│   ├── t14/                        current machine and real hardware config
│   └── i5-5060/                    future desktop host
├── modules/
│   ├── profiles/                   reusable system bundles
│   ├── core/                       boot, locale, network, Nix, security
│   ├── hardware/                   audio, Bluetooth, fonts, power, GPUs
│   ├── desktop/                    greetd, Niri, Noctalia dependencies
│   ├── networking/                 AmneziaWG service
│   ├── packages/                   system-wide and recovery software
│   └── users/                      local account configuration
├── home/
│   ├── profiles/                   desktop and terminal bundles
│   ├── common/                     shared Gruvbox palette and GTK theme
│   ├── desktop/                    generated Niri and Noctalia configs
│   ├── packages/                   daily user CLI packages
│   └── programs/                   application-specific Home Manager config
├── docs/                           installation and maintenance guides
└── .agents/skills/                 project knowledge for Codex
```

The ownership rule is simple:

- `modules/` changes the operating system and system-wide software.
- `home/` changes the `mrgnl` user environment and managed dotfiles.
- `host/` contains only machine-specific composition and hardware state.

See [docs/structure.md](docs/structure.md) for the detailed import flow.

## Current Machine

Evaluate and build before activation:

```sh
cd /etc/nixos
nix fmt --accept-flake-config -- --ci
nix flake check --accept-flake-config
nixos-rebuild dry-build --flake .#t14 --accept-flake-config
```

Apply the checked generation:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

Check the result:

```sh
systemctl --failed
systemctl --user --failed
systemctl status home-manager-mrgnl.service
```

The complete walkthrough is in
[docs/install-current.md](docs/install-current.md).

## Common Changes

| Goal | Edit |
| --- | --- |
| Add a system or recovery CLI | `modules/packages/cli/` |
| Add a graphical application | `modules/packages/gui/` |
| Add a daily user CLI | `home/packages/` |
| Configure a user program | `home/programs/` |
| Change shared colors | `home/common/colors.nix` |
| Change Niri | `home/desktop/niri/` |
| Change Noctalia | `home/desktop/noctalia/` |
| Change a machine | `host/<name>/configuration.nix` |
| Change reusable hardware behavior | `modules/hardware/` |

Search both package layers before adding software:

```sh
rg -n 'package-name' modules home
```

More examples are in [docs/manage-config.md](docs/manage-config.md).

## Validation

The project skill includes a repeatable checker:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh quick t14
```

Use the full cross-host build after changing shared modules, profiles, flake
inputs, Home Manager wiring, or host definitions:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh full t14
```

After switching desktop changes, validate the live generated configs:

```sh
niri validate -c ~/.config/niri/config.kdl
noctalia config validate ~/.config/noctalia
```

See [docs/checks.md](docs/checks.md) for the validation matrix.

## Secrets

VPN keys are not stored in Git. The system expects the private AmneziaWG
configuration at:

```text
/etc/amnezia/awg0.conf
```

Keep it root-owned with mode `0600`.

## RTX 5060 Migration

Do not switch the `i5-5060` output on the ThinkPad. On the new machine:

1. Generate a real hardware configuration.
2. Install the private VPN file.
3. Bring up and verify VPN.
4. Build `.#i5-5060`.
5. Switch only after the build succeeds.

Follow [docs/migrate-i5-5060.md](docs/migrate-i5-5060.md).

## Project Skill

Codex-specific project knowledge lives in:

```text
.agents/skills/maintain-mrgnl-nixos/
```

It documents ownership boundaries, runtime invariants, validation, migration
constraints, and commit conventions. Invoke it explicitly with:

```text
$maintain-mrgnl-nixos
```

## Git Convention

Use small commits with lowercase imperative English messages:

```text
add transmission client
fix noctalia bar ownership
document desktop migration
```

## Documentation

- [Repository structure](docs/structure.md)
- [Checks and validation](docs/checks.md)
- [Current installation](docs/install-current.md)
- [Configuration handbook](docs/manage-config.md)
- [Terminal aliases](docs/aliases.md)
- [RTX 5060 migration](docs/migrate-i5-5060.md)

Screenshots can be added under `docs/screenshots/` when the final desktop layout
is ready.
