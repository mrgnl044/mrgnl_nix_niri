inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  nixos-hardware.url = "github:NixOS/nixos-hardware/master";
};

outputs = { self, nixpkgs, nixos-hardware, ... }: {
  nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      nixos-hardware.nixosModules.lenovo-thinkpad

      ./host/t14/configuration.nix
    ];
  };
};
