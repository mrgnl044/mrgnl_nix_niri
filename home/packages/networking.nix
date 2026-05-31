{ pkgs, ... }:

{
  home.packages = with pkgs; [
    doggo
    dnsutils
    inetutils
    mtr
    nmap
    socat
    traceroute
    whois
    xh
  ];
}
