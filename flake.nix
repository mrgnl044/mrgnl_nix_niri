{
  description = "mrgnl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos_hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos_hardware, ... }: {
    nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./host/t14/configuration.nix
        nixos_hardware.nixosModules.lenovo-thinkpad
      ];
    };
  };
}
