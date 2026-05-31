# System profiles

Profiles are reusable bundles.

- `base.nix` is required for normal machines.
- `graphical.nix` adds the desktop stack.
- `laptop.nix` adds laptop-specific power and Intel graphics.
- `desktop-intel-nvidia.nix` is prepared for an Intel desktop with NVIDIA RTX 5060.

Hosts should import profiles instead of importing every low-level module directly.
