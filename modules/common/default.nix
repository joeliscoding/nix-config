{ config, ... }:

{
  imports = [
    ./btop.nix
    ./tailscale.nix
  ];
}
