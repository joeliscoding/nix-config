{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    shellIntegration.enableFishIntegration = true;

    settings = {
      shell = "fish";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # cursor
      cursor_trail = 1;

      # window
      window_padding_width = 10;
      background_opacity = 0.8;
    };
  };
}
