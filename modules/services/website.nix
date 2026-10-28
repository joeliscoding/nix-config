{ config, pkgs, inputs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts."joeliscod.ing" = {
      extraConfig = ''
        root * ${inputs.joeliscoding-website.packages.${pkgs.system}.default}
        file_server
        encode gzip zstd
      '';
    };
  };
}
