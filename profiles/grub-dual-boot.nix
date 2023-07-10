{
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;

      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];

      useOSProber = true;

      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }

        menuentry "Off" {
          halt
        }
      '';
    };
  };
}
