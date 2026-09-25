{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awww
    firefox
    nautilus
    vesktop
  ];
}
