{
  home-manager,
  inputs,
  nixpkgs,
  ...
}:

modules:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
  };

  modules = modules ++ [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-backup";
        sharedModules = [ inputs.noctalia.homeModules.default ];
        users.mrgnl = import ../home/mrgnl.nix;
      };
    }
  ];
}
