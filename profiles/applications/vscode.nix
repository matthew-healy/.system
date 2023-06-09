{ pkgs, ... }: {
  home-manager.users.matthew.programs.vscode = {
    enable = true; 

    userSettings = {
      "editor.fontFamily" = "'Fira Code', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.rulers" = [ 80 120 ];
      "editor.tabSize" = 2;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "haskell.manageHLS" = "PATH";
      "rust-analyzer.cargo.features" = "all";
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Pink Cat Boo";
    };

    extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        haskell.haskell
        jnoortheen.nix-ide
        justusadam.language-haskell
        matklad.rust-analyzer
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "theme-pink-cat-boo";
          publisher = "ftsamoyed";
          version = "1.3.0";
          sha256 = "FD7fim0sRWAADzDAbhV3dnYW3mxoSgVPLs5Wkg5r01k=";
        }
      ];
  };
}
