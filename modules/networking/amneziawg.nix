{ ... }:

{
  networking.wg-quick.interfaces.awg0 = {
    type = "amneziawg";
    configFile = "/etc/amnezia/awg0.conf";
    autostart = true;
  };
}
