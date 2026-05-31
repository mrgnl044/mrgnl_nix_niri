{ pkgs, ... }:

{
  users.users.mrgnl = {
    isNormalUser = true;
    description = "mrgnl";
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
  };
}
