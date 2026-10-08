{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix

    ./1password
    ./hyprland
    ./kitty.nix
    ./matugen
    ./neovim
    ./quickshell
    ./starship.nix
    ./yazi.nix

    ./cursor.nix
  ];
}
