{
  description = "My very cool nixos system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager... }@inputs:
    let
      inherit (self) outputs;
    in {

        nixosConfigurations = {
          yrnNixDesktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              machines/desktop.nix,
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                # TODO replace ryan with your own username
                home-manager.users.yrn = import ./home-manager/home.nix;

                # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              }
            ];
          };
        };

    };
}
