{ pkgs, config, ... }:

{
  environment.systemPackages = [
    pkgs.beszel
  ];

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
