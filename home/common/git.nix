{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "joeliscoding";
        email = "91632635+joeliscoding@users.noreply.github.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG35YTvacglyHhEY2YEars+6kvqmwr78/2sA79rZx3SH";
      };

      init.defaultBranch = "main";
    };
  };
}
