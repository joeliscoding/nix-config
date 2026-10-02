{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    
    ./cursor.nix
    
    ./1password
    ./fish.nix
    ./git.nix
    ./hyprland
    ./kitty.nix
    ./neovim
    ./quickshell
    ./starship.nix
  ];

  home.username = "joel";
  home.homeDirectory = "/home/joel";

  home.stateVersion = "26.05"; # do not change

  programs.home-manager.enable = true;
}
