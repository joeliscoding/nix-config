{ ... }:

{
  imports = [
    ./packages.nix

    ./bluetooth.nix
    ./power-configuration.nix
    ./fonts.nix

    ./1password.nix
    ./hyprland.nix
    ./iwd
  ];
}
