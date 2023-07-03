{ config, ... }: {
  home-manager.users.matthew.services.mpd = {
    enable = true;

    musicDirectory = "${config.users.users.matthew.home}/Music";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire Output"
      }
    '';
  };

  home-manager.users.matthew.programs.ncmpcpp.enable = true;
}
