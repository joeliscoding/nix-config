{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awww
    fastfetch
    firefox
    nautilus
    slack
    spotify
    vesktop
  ];
}
