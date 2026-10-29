{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/joel/.config/sops/age/keys.txt";
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
