{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "joeliscoding";
        email = "hi@joeliscod.ing";
        signingKey = "40362489A1F8CD6E";
      };

      commit.gpgsign = true;
      push.followtags = true;

      init.defaultBranch = "main";
    };
  };
}
