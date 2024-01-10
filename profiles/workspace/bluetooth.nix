{
  hardware.bluetooth = {
    enable = true;

    # Apple Trackpad won't work without this: https://github.com/bluez/bluez/issues/664
    input = {
      General = {
        ClassicBondedOnly = false;
      };
    };
  };
  services.blueman.enable = true;

  home-manager.users.matthew.programs.bash =
    let
      trackpad = "64:B0:A6:E6:CB:5B";
      headphones = "90:9C:4A:DE:C1:61";
    in
    {
      shellAliases = {
        "bt-trackpad" = "echo \"${trackpad}\"";
        "bt-headphones" = "echo \"${headphones}\"";
      };
    };
}
