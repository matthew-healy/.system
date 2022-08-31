{
  description = "My system configuration";

  inputs = {
    nixpkgs = {
      type  = "github";
      owner = "NixOS";
      repo  = "nixpkgs";
      ref   = "nixos-22.05";
    };

    home-manager = {
      type  = "github";
      owner = "nix-community";
      repo  = "home-manager";
      ref   = "release-22.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        foundation = lib.nixosSystem {
          inherit system;

          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            ./fonts.nix
          ];
        };
      };
    };
}
