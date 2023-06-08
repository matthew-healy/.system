{ pkgs
, ...
}: {
  # some of this might be better in a hardware/base.nix module
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    efi.canTouchEfiVariables = false;
    grub = {
      enable = true;

      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];

      useOSProber = true;

      extraEntries = ''
        menuentry "reboot" {
          reboot
        }

        menuentry "off" {
          halt
        }
      '';
    };
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_GB.utf8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  virtualisation.docker.enable = true;

  services.xserver = {
    layout = "us,gb";
    xkbVariant = "";
  };
  console.keyMap = "us";

  services.printing.enable = true;
  services.fwupd.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" "ca-derivations" ];

  nix.settings.trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  nix.settings.substituters = [ "https://cache.iog.io" ];
  nix.settings.trusted-users = [ "root" "matthew" ];

  users.users.matthew = {
    isNormalUser = true;
    description = "matthew";
    extraGroups = [ "audio" "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      _1password-gui
      # lld, but wrapped to set the rpath correctly
      llvmPackages.bintools
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    direnv
    docker
    git
    keychain
    nil
    vim
    wget
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
