{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      command_timeout = 1000;

      "$schema" = "https://starship.rs/config-schema.json";

      character = {
        success_symbol = "[󰅏 ❯](white)";
        error_symbol = "[[󰅏](red) ❯](red)";
        vimcmd_symbol = "[󰅏 ❮](white)"; # For use with zsh-vi-mode
      };

      git_branch = {
        style = "bold white";
      };

      directory = {
        truncation_length = 4;
        style = "bold white";
      };
    };
  };
}
