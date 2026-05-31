{ ... }:

{
  networking.wg-quick.interfaces.awg0 = {
    type = "amneziawg";
    configFile = "/etc/amnezia/awg0.conf";

    # Пока не запускаем на старте.
    # Сначала проверим руками.
    autostart = true;
  };
}
