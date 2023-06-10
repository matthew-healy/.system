{ config, ... }: {
  startupApplications = with config.defaultApplications; [
    browser.cmd
    pw-mgr.cmd
  ];

  environment.sessionVariables = with config.defaultApplications; {
    EDITOR = editor.cmd;
    VISUAL = editor.cmd;
  };

  home-manager.users.matthew.xdg = {
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
}
