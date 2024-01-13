{
  description = "matthew's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:rycee/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-trunk = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    direnv-trunk = {
      url = "github:direnv/direnv";
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
        overlays = [ self.overlay ];
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
              findModules (dir + "/${name}"))
          (builtins.readDir dir)));

    in
    {
      nixosModules = builtins.listToAttrs (findModules ./modules);

      nixosProfiles = builtins.listToAttrs (findModules ./profiles);

      nixosRoles = import ./roles;

      nixosConfigurations =
        let
          hosts = builtins.attrNames (builtins.readDir ./machines);

          makeHost = name:
            lib.nixosSystem {
              inherit system;

              modules = builtins.attrValues self.nixosModules ++ [
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
        in
        lib.genAttrs hosts makeHost;

      overlay = import ./overlay.nix inputs;

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
