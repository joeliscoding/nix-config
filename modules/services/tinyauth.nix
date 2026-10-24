{ config, ... }:
let
  authHost = "auth.blauerninja.de";
  idHost   = "id.blauerninja.de";
in
{
  sops.secrets."tinyauth/oidc_client_id"     = { };
  sops.secrets."tinyauth/oidc_client_secret" = { };

  sops.templates."tinyauth.env".content = ''
    TINYAUTH_OAUTH_PROVIDERS_POCKETID_CLIENTID=${config.sops.placeholder."tinyauth/oidc_client_id"}
    TINYAUTH_OAUTH_PROVIDERS_POCKETID_CLIENTSECRET=${config.sops.placeholder."tinyauth/oidc_client_secret"}
  '';

  services.tinyauth = {
    enable = true;
    environmentFile = config.sops.templates."tinyauth.env".path;
    settings = {
      APPURL = "https://${authHost}";
      SERVER_PORT = 3000;
      OAUTH_PROVIDERS_POCKETID_NAME = "Pocket ID";
      OAUTH_PROVIDERS_POCKETID_AUTHURL = "https://${idHost}/authorize";
      OAUTH_PROVIDERS_POCKETID_TOKENURL = "https://${idHost}/api/oidc/token";
      OAUTH_PROVIDERS_POCKETID_USERINFOURL = "https://${idHost}/api/oidc/userinfo";
      OAUTH_PROVIDERS_POCKETID_REDIRECTURL = "https://${authHost}/api/oauth/callback/pocketid";
      OAUTH_PROVIDERS_POCKETID_SCOPES = "openid email profile groups";
      OAUTH_AUTOREDIRECT = "pocketid";
    };
  };

  services.caddy.virtualHosts.${authHost}.extraConfig = ''
    reverse_proxy 127.0.0.1:3000
  '';
}
