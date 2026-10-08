{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    pocket-id
  ];

  services.pocket-id = {
    enable = true;

    credentials = {
      ENCRYPTION_KEY = "/etc/secrets/pocket-id/encryption-key";
    };

    settings = {
      # <https://pocket-id.org/docs/configuration/environment-variables>
      APP_URL = "https://auth.blauerninja.de";
      TRUST_PROXY = true;
      HOST = "127.0.0.1";
      PORT = 1411;
    };
  };
}
