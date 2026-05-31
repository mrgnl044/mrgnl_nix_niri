{ pkgs, ... }:

{
  home.packages = with pkgs; [
    doggo
    dnsutils
    httpie
    inetutils
    mtr
    nmap
    socat
    traceroute
    whois
    xh
  ];
}
