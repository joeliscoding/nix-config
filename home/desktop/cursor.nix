{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;

    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;

    gtk.enable = true;   # sets GTK cursor theme + size
    x11.enable = true;   # sets XCursor for XWayland apps (writes ~/.icons and xrdb)
    hyprcursor.enable = true; # optional, sets HYPRCURSOR_* env vars (see note below)
  };
}
