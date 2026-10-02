{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  # GNOME Keyring
  services.gnome.gnome-keyring.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  programs.nh = {
    enable = true;
    flake = "/home/joel/nix-config";
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 7d";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."joel" = {
    isNormalUser = true;
    description = "joel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  programs.hyprland.enable = true;



  system.stateVersion = "26.05"; # do not change

}
