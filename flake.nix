{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    degoog = {
      url = "github:degoog-org/degoog";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    joeliscoding-website.url = "github:joeliscoding/website";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    degoog,
    joeliscoding-website,
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

            sops-nix.nixosModules.sops
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
        degoog.nixosModules.default
      ];
    };

    homeConfigurations = {
      "joel@joel-surface" = mkHome "joel-surface";
      "joel@ninjago" = mkHome "ninjago";
    };
  };
}
