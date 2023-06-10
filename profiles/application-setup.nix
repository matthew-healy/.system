{ config, pkgs, ... }: {
  environment.sessionVariables = with config.defaultApplications; {
    EDITOR = editor.cmd;
    VISUAL = editor.cmd;
  };

  home-manager.users.matthew = {
    # TODO: this is a bit of a hack & requires explicit references to the
    #       packages i want to start up. it'd be much nicer to be able to set
    #       the autostartPrograms based on defaultApplications. this works for
    #       now though.
    home.file =
      let autostartPrograms = [ pkgs._1password-gui pkgs.kitty pkgs.firefox ]; in
      builtins.listToAttrs (map
        (pkg:
          {
            name = ".config/autostart/" + pkg.pname + ".desktop";
            value =
              if pkg ? desktopItem then {
                text = pkg.desktopItem.text;
              } else {
                source = (pkg + "/share/applications/" + pkg.pname + ".desktop");
              };
          })
        autostartPrograms);

    xdg = {
      enable = true;

      mimeApps = {
        enable = true;

        defaultApplications = with config.defaultApplications;
          builtins.mapAttrs
            (name: value: if value ? desktop then [ "${value.desktop}.desktop" ] else value)
            {
              "text/html" = browser;
              "application/zip" = archive;
              "application/rar" = archive;
              "application/7z" = archive;
              "application/*tar" = archive;
              "x-scheme-handler/http" = browser;
              "x-scheme-handler/https" = browser;
              "x-scheme-handler/about" = browser;
              "x-scheme-handler/matrix" = browser;
              "text/plain" = editor;
              "text/*" = editor;
            };
      };
    };
  };
}
