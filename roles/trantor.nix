{ inputs, pkgs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    slack
    unpackaged-programs
  ];

  networking.hostName = "trantor";
}
