{ lib, pkgs, ... }:

{
  programs.git.settings = {
    "gpg \"ssh\"" = {
      program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    };
  };
}
