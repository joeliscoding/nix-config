{ pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "joel";
    dataDir = "/srv/syncthing";
    openDefaultPorts = true;
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
