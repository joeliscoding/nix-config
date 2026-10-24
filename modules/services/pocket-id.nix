{ pkgs, config, ... }:

let
  host = "id.blauerninja.de";
in
{
  sops.secrets."pocket-id/encryption-key" = { };

  services.caddy.virtualHosts."${host}".extraConfig = ''
    reverse_proxy http://127.0.0.1:1411
  '';

  services.pocket-id = {
    enable = true;

    credentials = {
      ENCRYPTION_KEY = config.sops.secrets."pocket-id/encryption-key".path;
    };

    settings = {
      # <https://pocket-id.org/docs/configuration/environment-variables>
      APP_URL = "https://${host}";
      TRUST_PROXY = true;
      HOST = "127.0.0.1";
      PORT = 1411;
    };
  };
}
