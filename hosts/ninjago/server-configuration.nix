{ ... }:

{
  networking = {
    useDHCP = false;

    interfaces.ens18 = {
      ipv4.addresses = [{
        address="136.243.51.142";
        prefixLength=26;
      }];
    };

    defaultGateway = "136.243.51.129";
    nameservers = ["185.12.64.1" "185.12.64.2" "1.1.1.1" "8.8.8.8"];
  };
}
