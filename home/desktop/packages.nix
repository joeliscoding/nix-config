{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awww
    fastfetch
    firefox
    nautilus
    signal-desktop
    slack
    spotify
    vesktop
    vscodium
  ];
}
