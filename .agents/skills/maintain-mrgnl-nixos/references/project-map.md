# Project Map

## Import Flow

```text
flake.nix
└── lib/mk-host.nix
    ├── host/<name>/configuration.nix
    │   └── modules/profiles/*.nix
    │       └── modules/{core,hardware,desktop,networking,packages,users}
    └── home/mrgnl.nix
        └── home/profiles/*.nix
            └── home/{common,desktop,packages,programs}
```

`lib/mk-host.nix` attaches the same Home Manager user to every host and imports
the official Noctalia Home Manager module.

## Host Registry

| Host | Role | System profiles |
| --- | --- | --- |
| `t14` | Current ThinkPad | `base`, `graphical`, `laptop` |
| `i5-5060` | Intel desktop and RTX 5060 migration target | `desktop-intel-nvidia` |

`i5-5060` evaluates without a hardware file by using a temporary root fallback.
That fallback exists only for CI and pre-migration builds.

## Ownership

| Area | Owner |
| --- | --- |
| Flake inputs, formatter, host registry | `flake.nix` |
| Shared host constructor and Home Manager wiring | `lib/mk-host.nix` |
| Machine hardware and profile selection | `host/<name>/` |
| Boot, locale, networking, Nix, security | `modules/core/` |
| Audio, Bluetooth, fonts, power, GPU | `modules/hardware/` |
| greetd, Niri package, Noctalia dependencies | `modules/desktop/` |
| System-wide CLI and GUI packages | `modules/packages/` |
| AmneziaWG service wiring | `modules/networking/` |
| Local account and groups | `modules/users/` |
| Home Manager entrypoint and identity | `home/mrgnl.nix`, `home/session.nix` |
| Gruvbox palette and GTK theme | `home/common/` |
| Generated Niri and Noctalia config | `home/desktop/` |
| Daily user CLI packages | `home/packages/` |
| Program-specific user config | `home/programs/` |
| User-facing instructions | `README.md`, `docs/` |

## Desktop Runtime

greetd starts `niri-session`. Niri owns session autostart, including Noctalia.
Home Manager generates Niri KDL fragments and Noctalia TOML/palette files.

Important boundaries:

- Do not start Noctalia from both Niri and systemd.
- Keep one configured bar, currently `bar.default`.
- Keep shared colors in `home/common/colors.nix`.
- Put Niri effects in `home/desktop/niri/effects.nix` and matching window or
  layer selection in `rules.nix`.

## Package Placement

Use `modules/packages/` when a package must be available system-wide, to root,
or during recovery. Use `home/packages/` for daily user CLI tools. Use
`home/programs/` when Home Manager has configuration to manage.

Before adding a package, search both layers:

```sh
rg -n 'package-name' modules home
```

Avoid parallel tools with the same primary job unless the user explicitly wants
both.

## Hardware And Secrets

- `host/t14/hardware-configuration.nix` is real generated hardware state.
- `host/i5-5060/hardware-configuration.nix` must be generated on the new PC.
- NVIDIA behavior lives in `modules/hardware/gpu/nvidia.nix`.
- Never commit VPN keys or `/etc/amnezia/awg0.conf`.
