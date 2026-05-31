{ ... }:

{
  networking.wg-quick.interfaces.awg0 = {
    type = "amneziawg";
    configFile = "/etc/amnezia/awg0.conf";
    autostart = true;
  };

  systemd.services.greetd = {
    after = [ "wg-quick-awg0.service" ];
    requires = [ "wg-quick-awg0.service" ];
  };
}
