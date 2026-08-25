{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (_final: prev: {
      amneziawg-go = prev.amneziawg-go.overrideAttrs (_old: {
        version = "3.1.20260814";
        src = prev.fetchFromGitHub {
          owner = "amnezia-vpn";
          repo = "amneziawg-go";
          tag = "v3.1.20260814";
          hash = "sha256-HMmbKd1wYzotB+GAZ8GulyJmX7+XUnXOEerab0OCPO8=";
        };
        vendorHash = "sha256-Y2dCwlKMVLrkzDcNKyCPxFJwMbCA2mQKkakvzwbamCY=";
      });

      amneziawg-tools = prev.amneziawg-tools.overrideAttrs (_old: {
        version = "3.1.20260812";
        src = prev.fetchFromGitHub {
          owner = "amnezia-vpn";
          repo = "amneziawg-tools";
          tag = "v3.1.20260812";
          hash = "sha256-6GEb41ERhR0Hg3RbSyIHdXPSKaxugoFCmFS5S0UiZso=";
        };
      });
    })
  ];

  boot.blacklistedKernelModules = [ "amneziawg" ];

  environment.systemPackages = [
    pkgs.amneziawg-go
    pkgs.amneziawg-tools
  ];

  systemd.services.wg-quick-awg0 = {
    description = "AmneziaWG userspace tunnel - awg0";
    requires = [ "network-online.target" ];
    after = [
      "network.target"
      "network-online.target"
    ];
    wantedBy = [ "multi-user.target" ];
    path = [
      pkgs.amneziawg-go
      pkgs.amneziawg-tools
      config.networking.firewall.package
      config.networking.resolvconf.package
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = true;
    };

    preStart = ''
      ${pkgs.kmod}/bin/modprobe -r amneziawg 2>/dev/null || true
      install -m 600 /etc/amnezia/awg0.conf /tmp/awg0.conf
    '';
    script = ''
      awg-quick up /tmp/awg0.conf
    '';
    preStop = ''
      awg-quick down /tmp/awg0.conf
    '';
  };

  systemd.network.wait-online.ignoredInterfaces = [ "awg0" ];
}
