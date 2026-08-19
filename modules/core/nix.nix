{ ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      extra-substituters = [
        "https://noctalia.cachix.org"
      ];

      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];
    };

    gc = {
      automatic = true;
      dates = "Sun 03:15";
      options = "--delete-older-than 14d";
      randomizedDelaySec = "30min";
    };

    optimise = {
      automatic = true;
      dates = "Sun 04:15";
      randomizedDelaySec = "30min";
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = ''
    SystemMaxUse=256M
    MaxRetentionSec=14day
  '';
}
