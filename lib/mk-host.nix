{
  home-manager,
  nixpkgs,
  noctalia,
  noctalia-greeter,
  umbriel,
  xdg-desktop-portal-umbriel,
}:

modules:
let
  system = "x86_64-linux";
  patchedUmbriel = umbriel.packages.${system}.default.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/server/wine_color_manager.cpp \
        --replace-fail '.create_windows_bt2100 = nullptr,' \
        '/* Not available in the color-management protocol shipped by nixpkgs. */'
    '';
  });
in
nixpkgs.lib.nixosSystem {
  inherit system;

  modules = modules ++ [
    home-manager.nixosModules.home-manager
    noctalia-greeter.nixosModules.default
    umbriel.nixosModules.default
    {
      programs.umbriel = {
        package = patchedUmbriel;
        portalPackage = xdg-desktop-portal-umbriel.packages.${system}.default;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-backup";
        sharedModules = [
          noctalia.homeModules.default
          umbriel.homeModules.default
          { programs.umbriel.package = patchedUmbriel; }
        ];
        users.mrgnl = import ../home/mrgnl.nix;
      };
    }
  ];
}
