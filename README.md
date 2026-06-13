# mrgnl NixOS

Reproducible NixOS 26.05 configuration for a Niri and Noctalia 5 desktop with
Home Manager and a Gruvbox-dark user environment.

## Hosts

| Host | Status | Hardware |
| --- | --- | --- |
| `t14` | Active | Lenovo ThinkPad with Intel graphics |
| `i5-4060ti` | Migration target | Intel i5 desktop with NVIDIA RTX 4060 Ti 16 GB |

`i5-4060ti` can be evaluated and built before migration, but installation
requires a real generated `host/i5-4060ti/hardware-configuration.nix`.

## Stack

| Area | Components |
| --- | --- |
| System | NixOS 26.05, flakes, systemd-boot, NetworkManager |
| Desktop | Niri, greetd/tuigreet, Noctalia 5, Xwayland Satellite |
| Theme | Gruvbox Dark, Inter, JetBrains Mono Nerd Font |
| Terminal | Kitty, Fish, Starship, tmux |
| CLI | LazyVim, Yazi, btop, Git/Delta, fzf, zoxide |
| GUI | Firefox, Nautilus, Steam, Telegram, Spotify, Obsidian, Transmission |
| Network | NetworkManager and declarative AmneziaWG wiring |

## Layout

```text
flake.nix
├── lib/mk-host.nix          shared NixOS and Home Manager constructor
├── host/                    machine-specific composition and hardware
├── modules/                 reusable NixOS modules and system packages
├── home/                    Home Manager programs, packages, and dotfiles
└── .agents/skills/          local project maintenance tooling
```

Ownership rules:

- `host/` contains machine identity, hardware imports, and selected profiles.
- `modules/` owns NixOS services, hardware support, and system-wide software.
- `home/` owns the `mrgnl` environment and generated application config.

## Validation

Run the bundled checker before every completed change:

```sh
cd /etc/nixos
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh quick t14
```

Use the full cross-host check after shared modules, profiles, desktop
infrastructure, Home Manager wiring, flake inputs, or host changes:

```sh
.agents/skills/maintain-mrgnl-nixos/scripts/check.sh full t14
```

The checker verifies all local Nix syntax, local Markdown fences, formatting,
flake outputs, the selected host dry-build, generated Niri and Noctalia
configuration, and patch whitespace.

## Rebuild

After checks pass, apply the current laptop configuration:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

The Fish alias selects the current hostname automatically:

```sh
rebuild
```

Never switch `i5-4060ti` on the ThinkPad.

## Runtime Checks

After activation:

```sh
systemctl --failed
systemctl --user --failed
systemctl status home-manager-mrgnl.service
niri validate -c ~/.config/niri/config.kdl
noctalia config validate ~/.config/noctalia
```

## Editor

LazyVim is the default editor for terminal commands, Git-compatible tools,
Yazi, `vi`, `vim`, `vimdiff`, and common text-file MIME types. The first
`nvim` launch requires network access while Lazy.nvim downloads the plugin
set. Run `:LazyHealth` after the initial installation.

## Gaming

Steam and GameMode are enabled system-wide. The first Steam launch downloads
and installs the current client before showing the sign-in window. Steam can
also be started safely from terminals whose working directory is under
`/etc`; the wrapper falls back to the user's home directory before entering
its FHS environment.

Use this launch option for games that should run through GameMode:

```text
gamemoderun %command%
```

After the first rebuild that enables GameMode, sign out and back in once so
the `gamemode` group membership is present in the desktop session.

The Xiaomi ultrawide is pinned to the maximum mode exposed by the current
connection, `3440x1440@100.000`. The monitor does not currently advertise a
180 Hz mode; reaching 180 Hz requires a cable, port, or adapter combination
that exposes that mode in EDID.

## Maintenance

The system automatically:

- keeps at most 10 systemd-boot generations;
- removes Nix generations older than 14 days once a week;
- optimises the Nix store once a week while on AC power;
- limits persistent journal storage to 256 MiB and 14 days.

VPN secrets are not stored in Git. The private AmneziaWG configuration remains
root-owned at `/etc/amnezia/awg0.conf`.

## Git Workflow

Every completed change must follow:

```text
edit -> check -> commit -> push
```

Commit messages use lowercase imperative English. Push the current branch after
every checked commit:

```sh
git push -u origin "$(git branch --show-current)"
```

Only this root `README.md` is public. Other Markdown files are local personal
notes ignored by Git, while the checker still validates them.
