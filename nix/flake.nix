{
  description = "My very cool nixos system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
    in {

        nixosConfigurations = {
          yrnNixDesktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              inputs.stylix.nixosModules.stylix
              ./machines/desktop.nix
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.backupFileExtension = "backup";
                home-manager.useUserPackages = true;

                home-manager.users.yrn = import ./home-manager/home.nix;

                # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              }
            ];
          };
        };

    };
}
