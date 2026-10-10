{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    caddy
  ];

  services.caddy = {
    enable = true;
    virtualHosts."auth.blauerninja.de".extraConfig = ''
      reverse_proxy http://127.0.0.1:1411
    '';

    virtualHosts."beszel.blauerninja.de".extraConfig = ''
      reverse_proxy http://127.0.0.1:8090
    '';
  };
}
