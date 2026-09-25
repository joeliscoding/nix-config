{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "joeliscoding";
        email = "91632635+joeliscoding@users.noreply.github.com";
      };

      init.defaultBranch = "main";
    };
  };
}
