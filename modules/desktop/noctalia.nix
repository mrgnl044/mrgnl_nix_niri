{ pkgs, lib, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  noctaliaPackage = inputs.noctalia.packages.${system}.default;
in
{
  environment.systemPackages = with pkgs; [
    noctaliaPackage

    jq
    imagemagick

    brightnessctl
    cliphist
    wlsunset
  ];

  systemd.user.services.noctalia-shell = {
    description = "Noctalia shell";
    wantedBy = [ "niri.service" ];
    bindsTo = [ "niri.service" ];
    partOf = [ "niri.service" ];
    after = [ "niri.service" ];

    serviceConfig = {
      ExecStart = lib.getExe noctaliaPackage;
      Restart = "on-failure";
      RestartSec = 2;
    };
  };
}
