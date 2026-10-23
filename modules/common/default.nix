{ config, ... }:

{
  imports = [
    ./btop.nix
    ./gnupg.nix
    ./tailscale.nix
  ];
}
