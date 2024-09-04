{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    chromium
    slack
    password-quality
    unpackaged-programs
    autolock
  ];

  networking.hostName = "trantor";
}
