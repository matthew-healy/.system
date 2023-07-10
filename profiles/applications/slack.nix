{ pkgs, ... }: {
  # enables native wayland support for Slack (and maybe other stuff? idk)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.matthew.home.packages = [ pkgs.slack ];
}
