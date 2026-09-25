{ pkgs, ... }:

{
  # Enable networking
  # networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      DriverQuirks = {
        PowerSaveDisable = "";
      };
      General = {
        EnableNetworkConfiguration = true; # iwd does DHCP itself
      };
      Network = {
        NameResolvingService = "systemd"; # hand DNS to resolved
      };
    };
  };

  environment.etc."iwd/eduroam-hka-ca.pem".source = ./eduroam/hka-ca.pem;

  services.resolved.enable = true;

  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking.hostName = "joel-surface"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    impala
    iw
  ];
}
