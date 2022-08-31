{ config, pkgs, home-manager, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "foundation";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_GB.utf8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    layout = "us,gb";
    xkbVariant = "";
  };
  console.keyMap = "us";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];

  users.users.matthew = {
    isNormalUser = true;
    description = "Matthew Healy";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
      _1password-gui
      firefox
      gnome.gnome-sound-recorder
      slack
      vscode
    ];
  };

  home-manager.users.matthew = { pkgs, ... }: {
    services.gnome-keyring.enable = true;

    programs.keychain = {
      enable = true;
      agents = [ "ssh" ];
      keys = ["id_ed25519"];
      extraFlags = [ "--quiet" ];
    }; 
 
    programs.bash = {
      enable = true;
      
      historyIgnore = ["ls" "cd" ".."];
      
      sessionVariables = {
        EDITOR = "vim";
      };
 
      shellAliases = {
        ".." = "cd ..";
      };

      profileExtra = ''
        eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
        export SSH_AUTH_SOCK 
      '';

      bashrcExtra = ''
        function mkd() {
          mkdir -p "$1" && cd "$_";
        };
      '';
    };

    programs.git = {
      enable = true;

      userName = "Matthew Healy";
      userEmail = "matthew@liamhealy.xyz";

      aliases = {
        last = "log -1 HEAD";
        squash = "rebase -i --autosquash";
        debranch =
          let
            allBranches = ''git for-each-ref --format="%(refname:short)"'';
            filterCommonMains = ''egrep -v "(^\*|main|master|trunk|dev|develop$)"'';
            filterCurrentBranch = ''grep -v $(git branch --show-current)'';
            deleteRemainingBranches = ''xargs git branch -D'';
          in 
            "!" + allBranches         + "|"
                + filterCommonMains   + "|"
                + filterCurrentBranch + "|"
                + deleteRemainingBranches;
      };

      extraConfig = {
        apply.whitespace = "fix";

        color = {
          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };

          diff = {
            meta = "yellow bold";
            frag = "magenta bold";
            old = "red";
            new = "green";
          };

          status = {
            added = "yellow";
            changed = "green";
            untracked = "cyan";
          };

          ui = "auto";
        };

        core = {
          excludesFile = "~/.gitignore";

          whitespace = "space-before-tab,trailing-space";
        };

        help.autocorrect = 1;

        init.defaultBranch = "trunk";

        pull.rebase = true;
      };
    };
  };
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    direnv
    fprintd
    git
    keychain
    vim
    wget
  ];
  
  # Services

  # Fingerprint
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;

  # GNOME Keyring
  security.pam.services.gdm.enableGnomeKeyring = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
