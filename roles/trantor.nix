{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    pomodoro
    slack
  ];

  networking.hostName = "trantor";
}
