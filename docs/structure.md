# Repository structure

## Import flow

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

## Top-level ownership

| Path | Responsibility |
| --- | --- |
| `flake.nix` | Inputs, formatter, host registry, generated outputs |
| `lib/mk-host.nix` | Shared NixOS constructor and Home Manager integration |
| `host/` | Machine-specific hardware and profile selection |
| `modules/` | Reusable NixOS system modules |
| `home/` | Home Manager packages, programs, themes, and dotfiles |
| `docs/` | Installation and maintenance guides |
| `.agents/skills/` | Codex project procedures and reference material |

## System layer

`modules/profiles/` composes low-level modules:

- `base.nix`: boot, locale, networking, security, user, core packages, audio,
  Bluetooth, and fonts.
- `graphical.nix`: GUI packages, greetd, Niri, and Noctalia dependencies.
- `laptop.nix`: Intel graphics and laptop power management.
- `desktop-intel-nvidia.nix`: base + graphical + Intel + NVIDIA.

Use `environment.systemPackages` for software that root, recovery shells, or
the entire system should have.

## Home Manager layer

`home/mrgnl.nix` imports:

- `home/session.nix` for user identity and environment variables.
- `home/profiles/desktop.nix` for Gruvbox, Niri, and Noctalia.
- `home/profiles/terminal.nix` for packages and terminal programs.

Use `home.packages` for daily user tools. Use `programs.<name>` or
`xdg.configFile` when Home Manager should own application configuration.

## Desktop ownership

Home Manager generates Niri KDL fragments from `home/desktop/niri/` and
Noctalia configuration from `home/desktop/noctalia/`.

Niri starts Noctalia. Noctalia systemd startup remains disabled to prevent
duplicate shell instances. The configured bar is `bar.default`.

## Hosts

- `t14` imports real generated hardware configuration plus `base`, `graphical`,
  and `laptop`.
- `i5-5060` imports `desktop-intel-nvidia`. Its temporary root fallback exists
  only so the future host can evaluate before hardware generation.

Never install the future host without replacing the fallback with a real
`host/i5-5060/hardware-configuration.nix`.
