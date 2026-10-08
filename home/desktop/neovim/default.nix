{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    
    fzf
    tree-sitter
  ];

  xdg.configFile."nvim".source = ./nvim;
}
