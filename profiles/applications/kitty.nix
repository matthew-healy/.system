{ pkgs, ... }: {
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
      linux_display_server = "x11";
    };

    theme = "Tokyo Night Storm";
  };
}
