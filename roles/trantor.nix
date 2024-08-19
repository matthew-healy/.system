{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    chromium
    slack
    unpackaged-programs
  ];

  networking.hostName = "trantor";
}
