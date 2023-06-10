{ pkgs, ... }: {
  defaultApplications.pw-mgr = {
    cmd = "${pkgs._1password-gui}/bin/1password";
    desktop = "1password";
  };

  home-manager.users.matthew.home.packages = with pkgs; [
    _1password-gui
  ];
}
