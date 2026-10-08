{ config, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./ssh.nix
  ];

  home.username = "joel";
  home.homeDirectory = "/home/joel";

  home.stateVersion = "26.05"; # do not change

  programs.home-manager.enable = true;
}
