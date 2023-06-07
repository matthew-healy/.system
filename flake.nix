{
  description = "My system configuration";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, pre-commit-hooks }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      pre-commit = (pre-commit-hooks.lib.${system}.run {
        src = self;
        hooks.nixpkgs-fmt.enable = true;
      }).shellHook;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        shellHook = pre-commit;
      };

      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations =
        let
          makeSystem = hardware: lib.nixosSystem {
            inherit system;

            modules = [
              hardware
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
              ./home.nix
              ./fonts.nix
            ];
          };
        in
        {
          foundation = makeSystem ./hardware/terminus.nix;
          terminus = makeSystem ./hardware/terminus.nix;
        };
    };
}
