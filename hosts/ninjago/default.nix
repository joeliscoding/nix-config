{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./server-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device ="/dev/sda";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1";
    #useXkbConfig = true; # use xkb.options in tty.
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG35YTvacglyHhEY2YEars+6kvqmwr78/2sA79rZx3SH joel"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking = {
    hostName = "ninjago";

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22

        80
        443
      ];
    };
  };


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;




  system.stateVersion = "26.05"; # do not change

}
