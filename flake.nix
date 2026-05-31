{
  description = "mrgnl NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./host/t14/configuration.nix
      ];
    };
  };
}
