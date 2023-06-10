{ pkgs, ... }: {
  defaultApplications.archive = {
    cmd = "${pkgs.ark}/bin/ark";
    desktop = "org.kde.ark";
  };

  home-manager.users.matthew = {
    home.packages = [ pkgs.ark ];
  };
}
