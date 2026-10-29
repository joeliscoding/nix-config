{ config, ... }:

{
  imports = [
    ./btop.nix
    ./gnupg.nix
    ./sops.nix
    ./tailscale.nix
    ./users.nix
  ];
}
