{ pkgs, ... }:
{
  neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      lua << EOF
        ${builtins.readFile ./neovim/init.lua}
      EOF
    '';

    plugins = with pkgs.vimPlugins; [
      # for plugins that aren't in nixpkgs
      packer-nvim
      # automatically toggles between relative & actual line numbers
      vim-numbertoggle
    ];
  };
}
