{
  description = "My very cool nixos system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
    in {

        nixosConfigurations = {
          yrnNixDesktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ machines/desktop.nix ];
          };
        };

    };
}
