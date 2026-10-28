{ config, pkgs, ... }:

let
  searchHost = "search.blauerninja.de";
in
{
  sops.secrets."degoog/env" = {
    sopsFile = ../../secrets/degoog.env;
    format = "dotenv";
    #restartUnits = [ "degoog.service" ];
  };

  services.degoog = {
    enable = true;

    environmentFile = config.sops.secrets."degoog/env".path;

    environment = {
      PORT = "4444";
      DEGOOG_PUBLIC_INSTANCE = false;
      DEGOOG_BIND_ADDRESS = "127.0.0.1";
      DEGOOG_BASE_URL = "https://${searchHost}";
      DEGOOG_DISTRUST_PROXY = false;
    };
  };

  # Tinyauth
  services.caddy.virtualHosts.${searchHost}.extraConfig = ''
    forward_auth 127.0.0.1:3000 {
      uri /api/auth/caddy
      copy_headers Remote-User Remote-Name Remote-Email Remote-Groups
    }
    reverse_proxy 127.0.0.1:4444
  '';
}
