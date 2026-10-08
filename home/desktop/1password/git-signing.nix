{ lib, pkgs, ... }:

{
  programs.git = {
    settings = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG35YTvacglyHhEY2YEars+6kvqmwr78/2sA79rZx3SH";
      };
    };
  };
}
