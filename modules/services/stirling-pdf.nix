{ config, pkgs, ... }:

{
  sops.secrets."stirling-oidc/env" = {
    sopsFile = ../../secrets/stirling-oidc.env;
    format = "dotenv";
  };

  services.stirling-pdf = {
    enable = true;
    environment = {
      SERVER_PORT = 8484;
      SERVER_ADDRESS = "127.0.0.1";

      # Make Spring respect X-Forwarded-* from Caddy, so the OIDC
      # redirect URI is built as https://pdf.blauerninja.de/...
      SERVER_FORWARD_HEADERS_STRATEGY = "framework";

      SECURITY_ENABLELOGIN = "true";
      SECURITY_OAUTH2_ENABLED = "true";
      SECURITY_OAUTH2_ISSUER = "https://id.blauerninja.de";
      SECURITY_OAUTH2_PROVIDER="authentik";
      SECURITY_OAUTH2_CLIENTID = "e91df359-dd5f-466e-b996-67aedda00fce";
      SECURITY_OAUTH2_SCOPES = "openid,profile,email";
      SECURITY_OAUTH2_USEASUSERNAME = "email";
      SECURITY_OAUTH2_AUTOCREATEUSER = "true";   # create local users on first SSO login
      SECURITY_OAUTH2_BLOCKREGISTRATION = "false";
    };

    # Contains: SECURITY_OAUTH2_CLIENTSECRET=...
    environmentFiles = [ config.sops.secrets."stirling-oidc/env".path ];  # agenix, or sops-nix: config.sops.secrets.<name>.path
  };

  services.caddy = {
    enable = true;
    virtualHosts."pdf.blauerninja.de".extraConfig = ''
      encode zstd gzip
      reverse_proxy 127.0.0.1:8484
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
