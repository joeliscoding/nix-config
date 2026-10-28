{ config, pkgs, inputs, ... }:

let
  domain = "joeliscod.ing";
in
{
  services.caddy = {
    enable = true;

    virtualHosts."www.${domain}" = {
      extraConfig = ''
        redir https://${domain}{uri} permanent
      '';
    };

    virtualHosts."${domain}" = {
      extraConfig = ''
        root * ${inputs.joeliscoding-website.packages.${pkgs.stdenv.hostPlatform.system}.default}
        file_server
        encode gzip zstd
      '';
    };
  };
}
