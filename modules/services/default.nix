{ ... }:

{
  imports = [
    ./beszel.nix
    ./caddy.nix
    ./degoog.nix
    ./pocket-id.nix
    #./romm.nix # waiting for https://github.com/NixOS/nixpkgs/pull/580640 to get merged
    ./stirling-pdf.nix
    ./syncthing.nix
    ./tinyauth.nix
    ./website.nix
  ];
}
