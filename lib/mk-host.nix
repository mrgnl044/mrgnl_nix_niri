{
  home-manager,
  nixpkgs,
  noctalia,
}:

modules:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = modules ++ [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-backup";
        sharedModules = [ noctalia.homeModules.default ];
        users.mrgnl = import ../home/mrgnl.nix;
      };
    }
  ];
}
