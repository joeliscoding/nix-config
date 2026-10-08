{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    fuzzel
    git
    kitty
    wiremix
    wl-clipboard
    yazi
  ];
}
