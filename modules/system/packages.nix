{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    git
    kitty
    wl-clipboard
  ];
}
