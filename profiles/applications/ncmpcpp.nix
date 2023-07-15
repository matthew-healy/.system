{ ... }: {
  home-manager.users.matthew.services.mpd = {
    enable = true;

    # this is an external ssd, and even if it's plugged in on startup, the mpd
    # process seems to start before it gets mounted. right now the fix is just
    # to reload the library on launch. (it might be possible to only launch the
    # mpd process when a client connects, which could remove this need).
    musicDirectory = "/run/media/matthew/yoneda/music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire Output"
      }
    '';
  };

  home-manager.users.matthew.programs = {
    ncmpcpp = {
      enable = true;

      settings = {
        header_visibility = "yes";
        state_line_color = "white";

        progressbar_look = "━━━";
        progressbar_color = "white";
        statusbar_visibility = "yes";
        progressbar_elapsed_color = "cyan";
        statusbar_color = "cyan";
        song_status_format = "{%t - %a}";

        empty_tag_color = "white";

        main_window_color = "magenta";
        centered_cursor = "yes";
        enable_window_title = "yes";
        external_editor = "hx";
      };

      bindings = [
        { key = "j"; command = "scroll_down"; }
        { key = "k"; command = "scroll_up"; }
        { key = "h"; command = "previous_column"; }
        { key = "l"; command = "next_column"; }
      ];
    };

    bash.shellAliases."music" = "ncmpcpp";
  };
}
