{
  home-manager.users.matthew.programs.zoxide = {
    enable = true;

    options = [
      "--cmd cd"
    ];

    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
