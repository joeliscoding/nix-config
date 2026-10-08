{ pkgs, ... }:

{
  home.packages = [
    pkgs.quickshell
    pkgs.kdePackages.qtdeclarative
  ];

  xdg.configFile."quickshell".source = ./quickshell;
}

