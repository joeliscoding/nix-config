{ ... }:

{
  imports = [
    ./packages.nix

    ./bluetooth.nix
    ./networking
    ./power-configuration.nix
    ./fonts.nix

    ./1password.nix
    ./btop.nix
    ./hyprland.nix
  ];
}
