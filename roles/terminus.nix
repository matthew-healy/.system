{ ... }: {
  imports = [
    ./desktop.nix
    # whatever i want, like
  ];

  networking.hostName = "terminus";
}
