{ ... }: {
  zoxide = {
    enable = true;

    options = [
      "--cmd cd"
    ];

    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
