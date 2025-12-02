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

  services.pipewire.wireplumber.extraConfig."10-bluez" = {
    "monitor.bluez.properties" = {
      # Supposedly a better-quality audio codec.
      "bluez5.enable-sbc-xq" = true;
      # Before this headphone audio would break whenever the mic was in use.
      "bluez5.enable-msbc" = true;
    };
  };

  home-manager.users.matthew.programs.bash =
    let
      trackpad = "64:B0:A6:E6:CB:5B";
      headphones = "D0:C8:57:1F:13:47";
      airpods = "90:9C:4A:DE:C1:61";
      mouse = "DC:2D:21:E8:AA:DC";
    in
    {
      shellAliases = {
        "bt-trackpad" = "echo \"${trackpad}\"";
        "bt-headphones" = "echo \"${headphones}\"";
        "bt-airpods" = "echo \"${airpods}\"";
        "bt-mouse" = "echo \"${mouse}\"";
      };
    };
}
