<div align="center">

# mrgnl NixOS

**A reproducible Gruvbox desktop built around Umbriel, Noctalia 5 and Home Manager**

![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white)
![Wayland](https://img.shields.io/badge/Wayland-Umbriel-E95420?logo=wayland&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Fish-4EAA25?logo=gnubash&logoColor=white)
![Editor](https://img.shields.io/badge/Editor-LazyVim-57A143?logo=neovim&logoColor=white)
![Theme](https://img.shields.io/badge/Theme-Gruvbox-FABD2F)

</div>

This repository is the source of truth for my complete NixOS environment:
system services, hardware profiles, desktop behavior, applications, terminal
tools and dotfiles for my current ThinkPad.

## Screenshots

<p align="center">
  <img src="docs/screenshots/desktop.png" alt="Umbriel desktop with Noctalia and Kitty">
</p>

<p align="center">
  <b>Umbriel desktop</b><br>
  Noctalia shell, Kitty and Fastfetch on the active ThinkPad setup.
</p>

## Highlights

| | Feature | What it provides |
| --- | --- | --- |
| **Desktop** | Umbriel + Noctalia 5 | Scrollable Wayland tiling, launcher, bar, notifications, clipboard, lock screen and session controls |
| **Storage** | UDisks + GVfs | Removable drives appear in Nautilus and mount without root access |
| **Consistent UI** | Gruvbox Dark | Shared colors across Noctalia, Umbriel, Greeter, Kitty, btop, Yazi and LazyVim |
| **Developer setup** | LazyVim everywhere | `nvim` is the default editor for the shell, Git tools, Yazi and common text MIME types |
| **Gaming** | Steam + GameMode | 32-bit graphics support, performance mode and a Steam FHS wrapper that also works from `/etc/nixos` |
| **Single host** | ThinkPad profile | One focused configuration for the active `t14` laptop |
| **Biometrics** | Goodix fingerprint | Fingerprint unlock through fprintd for Noctalia, Greeter and sudo with password fallback |
| **Maintenance** | Automated cleanup | Compressed swap, SSD trimming, Nix store optimisation and bounded journal storage |
| **Reliable shutdown** | Bounded compositor stop | Umbriel gets five seconds to exit cleanly before systemd terminates a stuck DRM shutdown loop |
| **Validation** | Project checker | Parses every Nix file, validates Markdown, builds `t14` and checks generated Umbriel/Noctalia configuration |
| **Secrets** | Kept outside Git | AmneziaWG credentials remain root-owned under `/etc/amnezia/` |

## Desktop Experience

- Umbriel scrolling layout with custom rules, animations, global optimized
  window blur, fully opaque focused windows and overview.
- The Xiaomi ultrawide uses automatic HDR, while the ThinkPad panel is placed
  to its lower-right to match the physical desk layout.
- Noctalia 5 provides one integrated shell instead of several overlapping
  daemons.
- Noctalia Greeter provides a matching graphical login. Appearance sync is
  manual so wallpaper changes never trigger a Polkit password prompt.
- A single Gruvbox palette keeps the desktop and terminal applications
  visually consistent.
- Xwayland Satellite supports applications that still require X11.
- Letter shortcuts are mirrored across the US and Russian XKB layouts, so they
  remain attached to the same physical keys.

### Main Keybinds

| Shortcut | Action |
| --- | --- |
| `Mod + Return` | Open Kitty |
| `Mod + D` | Open Noctalia launcher |
| `Mod + B` | Open Firefox |
| `Mod + E` | Open Nautilus |
| `Mod + V` | Open clipboard history |
| `Mod + Alt + L` | Lock the session |
| `Mod + Shift + Q` | Open session menu |
| `Mod + O` | Toggle Umbriel overview |
| `Mod + F` | Toggle fullscreen |
| `Mod + T` | Toggle floating mode |
| `Ctrl + Shift + 1/2/3` | Screenshot selection/screen/selection |

## Software

| Area | Components |
| --- | --- |
| Base | NixOS 26.05, flakes, latest Linux kernel, systemd-boot |
| Session | greetd, Noctalia Greeter, Umbriel, Noctalia 5, Umbriel/GTK portals, GNOME Keyring, Xwayland Satellite |
| Terminal | Kitty, Fish, Starship, tmux |
| Editor | Neovim, LazyVim, Tree-sitter |
| CLI | Yazi, btop, Fastfetch, Git/Delta, LazyGit, fzf, zoxide, ripgrep, fd, eza |
| Development | GitHub CLI, ast-grep, hyperfine, LazyDocker, jq, yq |
| Desktop | Firefox, Nautilus, Obsidian, Spotify, Telegram, Transmission |
| Gaming | Steam, GameMode, 32-bit OpenGL/Vulkan support |
| Network | NetworkManager and declarative AmneziaWG service wiring |

## Hosts

| Host | Status | Hardware profile |
| --- | --- | --- |
| `t14` | Active | Lenovo ThinkPad, Intel graphics, laptop power management |

## Repository Layout

```text
.
├── flake.nix                 inputs and host registry
├── lib/mk-host.nix           shared NixOS + Home Manager constructor
├── host/
│   └── t14/                  active laptop hardware and composition
├── modules/
│   ├── core/                 boot, Nix, locale, networking, security
│   ├── desktop/              Greeter and Umbriel system integration
│   ├── hardware/             audio, Bluetooth, fingerprint, power, Intel GPU and VA-API
│   ├── networking/           AmneziaWG service wiring
│   ├── packages/             system CLI, GUI and gaming software
│   ├── profiles/             reusable system compositions
│   └── users/                local account configuration
├── home/
│   ├── common/               shared Gruvbox palette and GTK theme
│   ├── desktop/              generated Umbriel and Noctalia configuration
│   ├── packages/             daily user tools grouped by task
│   └── programs/             application-specific Home Manager modules
└── scripts/check.sh          project validation entrypoint
```

The ownership rule is simple:

- `host/` describes a specific machine.
- `modules/` owns reusable NixOS system behavior.
- `home/` owns the `mrgnl` user environment and dotfiles.

## Build And Validate

Run the quick checker for a normal change:

```sh
cd /etc/nixos
scripts/check.sh quick t14
```

Use the full system build after changing shared modules, profiles, desktop
infrastructure, Home Manager wiring, flake inputs or host definitions:

```sh
scripts/check.sh full t14
```

The checker:

1. Parses every local Nix file.
2. Checks Markdown fences and Nix formatting.
3. Evaluates all flake outputs.
4. Dry-builds the selected host.
5. Validates generated Umbriel and Noctalia configuration.
6. Builds the complete selected-host closure in full mode.
7. Rejects patch whitespace errors.

## Apply

Apply the configuration only for the machine currently in use:

```sh
sudo nixos-rebuild switch --flake .#t14 --accept-flake-config
```

Fish also provides a host-aware shortcut:

```sh
rebuild
```

After activation:

```sh
systemctl --failed
systemctl --user --failed
systemctl status home-manager-mrgnl.service
umbriel validate -c ~/.config/umbriel/config.toml
noctalia config validate ~/.config/noctalia
```

## Gaming Notes

Steam and GameMode are enabled system-wide. The first Steam launch downloads
the current client before showing the sign-in window.

To enable GameMode for a game, use this Steam launch option:

```text
gamemoderun %command%
```

After initially enabling GameMode, sign out and back in once so the desktop
session receives membership in the restricted `gamemode` group.

## Automatic Maintenance

- systemd-boot keeps at most 10 generations;
- zram handles memory pressure before the disk-backed swap;
- `/tmp` is cleaned on boot and SSD filesystems are trimmed weekly;
- Nix generations older than 14 days are removed weekly;
- new Nix store paths are deduplicated immediately and the full store is
  optimised weekly;
- persistent journal storage is limited to 256 MiB and 14 days.

## Git Workflow

Every completed change follows the same path:

```text
edit -> check -> commit -> push
```

Commit messages use lowercase imperative English. The root `README.md` is
public; personal Markdown notes are intentionally ignored by Git but still
validated locally by the project checker.
