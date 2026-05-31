{
  description = "mrgnl NixOS config";

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
    ];

    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixos_hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos_hardware,
      home-manager,
      noctalia,
      ...
    }:
    let
      system = "x86_64-linux";
      mkHost = import ./lib/mk-host.nix { inherit home-manager inputs nixpkgs; };

      hostModules = {
        t14 = [
          ./host/t14/configuration.nix
          nixos_hardware.nixosModules.lenovo-thinkpad
        ];

        i5-5060 = [
          ./host/i5-5060/configuration.nix
        ];
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = builtins.mapAttrs (_: modules: mkHost modules) hostModules;
    };
}
