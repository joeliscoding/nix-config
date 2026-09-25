{ ... }:

{
  imports = [
    ./packages.nix

    ./networking
    ./power-configuration.nix

    ./1password.nix
    ./hyprland.nix
  ];
}
