{ config, pkgs, ... }:

{
  imports = [
    ./ssh-agent.nix
    ./git-signing.nix
  ];
}
