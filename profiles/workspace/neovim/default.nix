{ pkgs, ... }: {
  home-manager.users.matthew.programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # for plugins that aren't in nixpkgs
      packer-nvim
      # automatically toggle between relative & actual line numbers
      vim-numbertoggle
    ];
  };
}