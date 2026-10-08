{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs: let
    system = "x86_64-linux";

    homeModules = {
      joel-surface = [
        ./home/common
        ./home/desktop
      ];

      ninjago = [
        ./home/common
      ];
    };

    mkHome = host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs; };
        modules = homeModules.${host};
      };

    mkHost = host: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules =
          [
            ./hosts/${host}
            ./modules/common
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.joel.imports = homeModules.${host};
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      joel-surface = mkHost "joel-surface" [
        ./modules/desktop
      ];

      ninjago = mkHost "ninjago" [
        ./modules/services
      ];
    };

    homeConfigurations = {
      "joel@joel-surface" = mkHome "joel-surface";
      "joel@ninjago" = mkHome "ninjago";
    };
  };
}
