{ config, ... }:

let
  rommHost = "romm.blauerninja.de";
  idHost = "id.blauerninja.de";
in
{
  sops.secrets."romm/env" = {
    sopsFile = ../../secrets/romm.env;
    format = "dotenv";
    key = "";
    restartUnits = [ "romm.service" "romm-worker.service" "romm-scheduler.service" "romm-watcher.service" ];
  };

  services.romm = {
    enable = true;
    nginx.virtualHost = "${rommHost}";
    environmentFile = config.sops.secrets."romm/env".path;

    extraEnvironment = {
      ROMM_BASE_URL = "https://${rommHost}";
      OIDC_ENABLED = "true";
      OIDC_PROVIDER = "pocket-id";
      OIDC_REDIRECT_URI = "https://${rommHost}/api/oauth/openid";
      OIDC_SERVER_APPLICATION_URL = "https://${idHost}";
    };
  };

  services.nginx.virtualHosts."${rommHost}".listen = [
    { addr = "127.0.0.1"; port = 8081; }
  ];

  services.caddy = {
    enable = true;
    virtualHosts."${rommHost}".extraConfig = ''
      reverse_proxy 127.0.0.1:8081
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
