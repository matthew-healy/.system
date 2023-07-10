{ ... }: {
  imports = [
    ./desktop.nix
    # slack etc.
  ];

  networking.hostName = "trantor";
}
