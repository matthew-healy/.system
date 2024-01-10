{
  hardware.bluetooth = {
    enable = true;

    # Apple Trackpad won't work without this: https://github.com/bluez/bluez/issues/664
    settings = {
      General = {
        ClassicBondedOnly = false;
      };
    };
  };
  services.blueman.enable = true;
}
