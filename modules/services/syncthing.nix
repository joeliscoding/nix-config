{ pkgs, config, ... }:

{
  sops.secrets."syncthing/gui-password" = {
    owner = config.services.syncthing.user;
  };

  systemd.tmpfiles.rules = [
    "d ${config.services.syncthing.dataDir} 0750 ${config.services.syncthing.user} ${config.services.syncthing.group} - -"
  ];

  services.syncthing = {
    enable = true;
    user = "joel";
    dataDir = "/srv/syncthing";
    openDefaultPorts = true;

    guiPasswordFile = config.sops.secrets."syncthing/gui-password".path;
    guiAddress = "0.0.0.0:8384";

    overrideDevices = true;
    overrideFolders = true;


    settings = {
      gui.user = "joel";
      devices = {
        "macbook" = { id = "AN6E6V6-UYTXHLB-A2N6GUA-RFEUCM6-7PVZ4XL-SFEGYTJ-UG2M52E-ZVFYIA6"; };
      };

    };
  };
}
