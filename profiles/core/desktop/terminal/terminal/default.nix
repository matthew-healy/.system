{ pkgs, ... }: {
  defaultApplications.term = {
    cmd = "${pkgs.kitty}/bin/kitty";
    desktop = "term";
  };

  environment.sessionVariables.SHELL = "${pkgs.bash}/bin/bash";

  home-manager.users.matthew = {
    programs.kitty = {
      enable = true;

      settings = {
        # This used to "just work" without this, but leaving this blank or
        # setting it to "${pkgs.bash}/bin/bash" breaks almost everything in
        # my config, and doing this magically fixes it soooo...
        shell = "bash";
        cursor_shape = "block";
        shell_integration = "no-cursor";
        font_size = "13.0";
        font_family = pkgs.desktop-config.font;
        background_opacity = "0.95";
      };

      themeFile = "tokyo_night_storm";
    };

    programs.bash = {
      enable = true;

      historyIgnore = [ "ls" "cd" ".." ];

      shellAliases = {
        ".." = "cd ..";
        "cat" = "${pkgs.bat}/bin/bat";
      };

      profileExtra = builtins.readFile ./bash_profile;
      bashrcExtra = builtins.readFile ./bashrc;
    };

    programs.zoxide = {
      enable = true;

      options = [
        "--cmd cd"
      ];

      enableZshIntegration = false;
      enableFishIntegration = false;
    };
  };
}
