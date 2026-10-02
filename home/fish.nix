{ config, pkgs, ... }:

{
 
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    shellAliases = {
      c = "clear";
      ll = "ls -l";
      la = "ls -la";
      v = "nvim";
      nv = "nvim";
      ff = "fastfetch";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    plugins = [
      #{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
    ];
  };
}

