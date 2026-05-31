# Migrate to Intel i5 + RTX 5060

Goal: boot the new machine, bring up VPN first, then switch the full desktop system.

## 1. Prepare secrets

Do not commit VPN secrets. Put the AmneziaWG config on the new machine manually:

```sh
sudo install -d -m 700 /etc/amnezia
sudo install -m 600 awg0.conf /etc/amnezia/awg0.conf
```

The declarative config expects this exact path:

```text
/etc/amnezia/awg0.conf
```

## 2. Generate hardware config

After booting the NixOS installer and mounting the installed system under `/mnt`:

```sh
sudo nixos-generate-config --root /mnt
sudo mkdir -p /mnt/etc/nixos/host/i5-5060
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/host/i5-5060/hardware-configuration.nix
```

Copy this repository to `/mnt/etc/nixos`, keeping `host/i5-5060/hardware-configuration.nix`.

## 3. Enable the new host in `flake.nix`

Add the host next to `t14`:

```nix
nixosConfigurations.i5-5060 = mkHost [
  ./host/i5-5060/configuration.nix
];
```

## 4. Test VPN before the full desktop

Boot or chroot into the installed system, then check VPN first:

```sh
sudo systemctl start wg-quick-awg0.service
systemctl status wg-quick-awg0.service
ip addr show awg0
```

Only continue when `awg0` exists and the service is active.

## 5. Build before switching

```sh
cd /etc/nixos
sudo nixos-rebuild dry-build --flake .#i5-5060 --accept-flake-config
```

## 6. Switch

```sh
sudo nixos-rebuild switch --flake .#i5-5060 --accept-flake-config
```

The config makes `greetd` require `wg-quick-awg0.service`, so the login screen waits for VPN. If the VPN config is missing or broken, fix `/etc/amnezia/awg0.conf` first.

## 7. NVIDIA notes

The `desktop-intel-nvidia` profile imports:

- Intel graphics support.
- NVIDIA latest driver package.
- NVIDIA open kernel module mode.
- `nvidia-drm.modeset=1`.

For a normal desktop with the monitor connected to the RTX 5060, this should be enough. If the machine is hybrid graphics, collect bus IDs:

```sh
lspci | grep -E "VGA|3D|Display"
```

Then add PRIME settings to `modules/hardware/gpu/nvidia.nix`.
