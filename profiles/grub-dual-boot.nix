{ pkgs, ... }: {
  boot.loader = {
    efi.canTouchEfiVariables = false;

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
