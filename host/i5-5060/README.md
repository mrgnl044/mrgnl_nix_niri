# i5-5060 host

This host is a migration template for an Intel i5 desktop with an NVIDIA RTX 5060.

Before enabling it in `flake.nix`:

1. Boot the new machine from the NixOS installer.
2. Mount the target system under `/mnt`.
3. Generate hardware config:

   ```sh
   nixos-generate-config --root /mnt --show-hardware-config > /mnt/etc/nixos/host/i5-5060/hardware-configuration.nix
   ```

4. Add `nixosConfigurations.i5-5060 = mkHost [ ./host/i5-5060/configuration.nix ];` to `flake.nix`.
5. Build once with `nixos-rebuild dry-build --flake /etc/nixos#i5-5060 --accept-flake-config`.

The NVIDIA module uses the latest driver package and the open kernel module path suitable for modern RTX cards. If the new machine is hybrid graphics instead of a desktop dGPU setup, add PRIME bus IDs after checking `lspci`.
