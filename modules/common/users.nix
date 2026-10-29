{ config, ... }:

{
  sops.secrets."users/joel/password" = {
    sopsFile = ../../secrets/users.yaml;
    neededForUsers = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;

    users.joel = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.sops.secrets."users/joel/password".path;
    };
  };
}
