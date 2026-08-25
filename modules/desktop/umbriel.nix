{ pkgs, ... }:

{
  programs.umbriel.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [
        "umbriel"
        "gtk"
      ];
      umbriel.default = [
        "umbriel"
        "gtk"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    libsecret
    wev
    xwayland-satellite
  ];
}
