{ pkgs, config, ... }:

{
  environment.systemPackages = [
    pkgs.beszel
  ];

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
      environmentFile = "/etc/secrets/beszel/env";   
    };
  };
}
