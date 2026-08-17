{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "mrgnl";
    group = "users";
    dataDir = "/home/mrgnl";
    configDir = "/home/mrgnl/.config/syncthing";
    extraFlags = [ "--allow-newer-config" ];
    openDefaultPorts = true;
  };
}
