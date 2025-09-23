{ config, pkgs, ... }: {
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
        font_family = config.font;
        background_opacity = "0.95";
      };

      extraConfig = ''
        include ~/.config/kitty/themes/root_loops.conf
      '';
    };
    home.file.".config/kitty/themes/root_loops.conf".text = with config.colours; ''
      background #${background}
      foreground #${foreground}
      selection_background #${foreground}
      selection_foreground #${background}

      cursor_text_color #${foreground}
      cursor #${cursor}

      url_color #${brightYellow}

      active_border_color #${cursor}
      inactive_border_color #${brightBlack}
      bell_border_color #${red}

      active_tab_foreground #${foreground}
      active_tab_background #${background}
      inactive_tab_foreground #${white}
      inactive_tab_background #${cursor}
      tab_bar_background #${background}

      mark1_foreground #${foreground}
      mark1_background #${brightRed}
      mark2_foreground #${foreground}
      mark2_background #${brightYellow}
      mark3_foreground #${foreground}
      mark3_background #${brightGreen}

      # black
      color0 #${black}
      color8 #${brightBlack}

      # red
      color1 #${red}
      color9 #${brightRed}

      # green
      color2  #${green}
      color10 #${brightGreen}

      # yellow
      color3  #${yellow}
      color11 #${brightYellow}

      # blue
      color4  #${blue}
      color12 #${brightBlue}

      # magenta
      color5  #${magenta}
      color13 #${brightMagenta}

      # cyan
      color6  #${cyan}
      color14 #${brightCyan}

      # white
      color7  #${white}
      color15 #${brightWhite}
    '';

    programs.bash = {
      enable = true;

      historyIgnore = [ "ls" "cd" ".." ];

      shellAliases = {
        ".." = "cd ..";
        "cat" = "${pkgs.bat}/bin/bat";
      };

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
