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
    wl-clipboard
    yazi
  ];
}
