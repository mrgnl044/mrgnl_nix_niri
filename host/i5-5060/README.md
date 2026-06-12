# i5-5060 host

Migration target for an Intel desktop with an NVIDIA RTX 5060.

The host is already registered in `flake.nix` and can be evaluated or built.
Until real hardware configuration exists, it uses a temporary tmpfs root only
to keep cross-host checks possible.

Before installation on the new machine:

1. Mount the target system under `/mnt`.
2. Generate hardware configuration:

   ```sh
   sudo nixos-generate-config --root /mnt
   sudo mkdir -p /mnt/etc/nixos/host/i5-5060
   sudo cp /mnt/etc/nixos/hardware-configuration.nix \
     /mnt/etc/nixos/host/i5-5060/hardware-configuration.nix
   ```

3. Install `/etc/amnezia/awg0.conf` with root ownership and mode `0600`.
4. Start and verify VPN.
5. Build `.#i5-5060`.
6. Switch only on the new desktop.

The NVIDIA module enables the current NVIDIA package, open kernel modules,
Wayland modesetting, and 32-bit graphics support. Add PRIME bus IDs only if the
new machine is actually hybrid graphics.

See [../../docs/migrate-i5-5060.md](../../docs/migrate-i5-5060.md).
