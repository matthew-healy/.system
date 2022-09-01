{ pkgs, ... }:
{
  vscode = {
    enable = true;

    userSettings = {
      "editor.fontFamily" = "'Fira Code', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "editor.tabSize" = 2;
      "explorer.confirmDragAndDrop" = false;
      "haskell.manageHLS" = "PATH";
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Pink Cat Boo";
    };

    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      haskell.haskell
      jnoortheen.nix-ide
      justusadam.language-haskell
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "theme-pink-cat-boo";
        publisher = "ftsamoyed";
        version = "1.3.0";
        sha256 = "FD7fim0sRWAADzDAbhV3dnYW3mxoSgVPLs5Wkg5r01k=";
      }
    ];
  };
}