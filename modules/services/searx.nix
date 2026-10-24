{ config, pkgs, ... }:
let
  searchHost = "search.blauerninja.de";
in
{
  sops.secrets."searx/secret_key" = { };

  sops.templates."searx.env".content = ''
    SEARX_SECRET_KEY=${config.sops.placeholder."searx/secret_key"}
  '';

  services.searx = {
    enable = true;
    package = pkgs.searxng;
    environmentFile = config.sops.templates."searx.env".path;
    settings = {
      use_default_settings = true;
      server = {
        bind_address = "127.0.0.1";
        port = 8888;
        secret_key = "@SEARX_SECRET_KEY@";
        limiter = false;
        public_instance = false;
      };
    };
  };

  # Tinyauth
  services.caddy.virtualHosts.${searchHost}.extraConfig = ''
    forward_auth 127.0.0.1:3000 {
      uri /api/auth/caddy
      copy_headers Remote-User Remote-Name Remote-Email Remote-Groups
    }
    reverse_proxy 127.0.0.1:8888
  '';
}
