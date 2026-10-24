{ pkgs, config, ... }:

{
  services.caddy.virtualHosts."beszel.blauerninja.de".extraConfig = ''
    reverse_proxy http://127.0.0.1:8090
  '';

  sops.secrets."beszel/env" = {
    sopsFile = ../../secrets/beszel.env;
    format = "dotenv";
    key = "";
  };

  services.beszel = {
    hub = {
      enable = true;
      port = 8090;
      environment = {
        USER_CREATION = "true";
        DISABLE_PASSWORD_AUTH="true";
      };
    };

    agent = {
      enable = true;
      environmentFile = config.sops.secrets."beszel/env".path;
    };
  };
}
