{
  description = "matthew's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:rycee/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;


      findModules = dir:
        builtins.concatLists (builtins.attrValues (builtins.mapAttrs
          (name: type:
            if type == "regular" then [{
              name = builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
              value = dir + "/${name}";
            }] else if (builtins.readDir (dir + "/${name}")) ? "default.nix" then [{
              inherit name;
              value = dir + "/${name}";
            }] else
              findModules (dir + "/${name}")) (builtins.readDir dir)));

    in
    {
      nixosProfiles = builtins.listToAttrs (findModules ./profiles);

      nixosRoles = import ./roles;

      nixosConfigurations =
        let
          hosts = builtins.attrNames (builtins.readDir ./machines);

          makeHost = name:
            lib.nixosSystem {
              inherit system;

              # Note: if/when i add modules, i'll want to add something like
              #       `__attrValues self.nixosModules` here
              modules = [
                inputs.home-manager.nixosModules.home-manager
                # TODO: move this somewhere more appropriate?
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                }
                { nixpkgs.pkgs = pkgs; }
                (import (./machines + "/${name}"))
              ];

              specialArgs = { inherit inputs; };
            };
        in lib.genAttrs hosts makeHost;


      devShells.${system}.default =
        let
          pre-commit = (inputs.pre-commit-hooks.lib.${system}.run {
            src = self;
            hooks.nixpkgs-fmt.enable = true;
          }).shellHook;
        in
          pkgs.mkShell {
            shellHook = pre-commit;
          };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
