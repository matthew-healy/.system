{ pkgs, lib, config, ... }: {
  options = {
    # Kitty 0.32+ doesn't get on well with Wayland + the current Nvidia drivers.
    # A fix is supposedly coming in the 550 driver release, but until then it's
    # good to have the option to easily switch a machine to x11.
    kitty.displayServer = lib.mkOption {
      type = lib.types.str;
      default = "auto";
    };
  };

  config = {
    defaultApplications.term = {
      cmd = "${pkgs.kitty}/bin/kitty";
      desktop = "term";
    };

    home-manager.users.matthew.programs.kitty = {
      enable = true;

      settings = {
        cursor_shape = "block";
        shell_integration = "no-cursor";
        font_size = "13.0";
        font_family = "FiraCode Nerd Font";
        background_opacity = "0.95";
        linux_display_server = config.kitty.displayServer;
      };

      theme = "Tokyo Night Storm";
    };
  };
}
