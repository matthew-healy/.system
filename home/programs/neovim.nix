{ pkgs, ... }:
{
  neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set encoding=utf-8 nobomb

      " centralise backups, swapfiles and undo history
      set backupdir=~/.vim/backups
      set directory=~/.vim/swaps
      if exists("&undodir")
        set undodir=~/.vim/undo
      endif

      " editing experience
      set number relativenumber
      syntax on
      set cursorline

      " search experience
      set hlsearch
      set ignorecase
      set incsearch

      " enable mouse in all modes
      set mouse=a

      " show filename in window title bar
      set title

      set showcmd

      set shiftwidth=2

      if has("autocmd")
        " enable file type detection
        filetype on
        " treat .json files as .js
        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
        " treat .md files as markdown
        autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
      endif
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      # automatically toggles between relative & actual line numbers
      vim-numbertoggle
    ];
  };
}
