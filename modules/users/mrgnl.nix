{ pkgs, ... }:

{
  users.users.mrgnl = {
    isNormalUser = true;
    description = "mrgnl";
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "gamemode"
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
  };
}
