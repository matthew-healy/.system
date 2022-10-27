vim.opt.encoding = "utf-8"

HOME = os.getenv("HOME")

-- centralise backups, swapfiles and undo history
vim.opt.backupdir = HOME .. "/.vim/backups"
vim.opt.directory = HOME .. "/.vim/swaps"
vim.opt.undodir = HOME .. "/.vim/undo"

-- editing experience
vim.cmd("syntax on") -- not 100% sure this is required
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = LightGrey })
-- 24-bit colour, required by nvim-notify
vim.opt.termguicolors = true;

-- search experience
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

-- enable mouse in all modes
vim.opt.mouse = "a"

-- show filename in window title bar
vim.opt.title = true

vim.opt.showcmd = true

vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- start scrolling 10 lines from end
vim.opt.scrolloff = 10

-- enable file type detection
vim.cmd("filetype on") -- not 100% sure this is required
-- treat .json files as .js
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.json",
  command = "setfiletype json syntax=javascript",
})
-- treat .md files as markdown
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.md",
  command = "setlocal filetype=markdown"
})

-- install packer dependencies
require('packer').startup(function(use)
  use 'LnL7/vim-nix'

  use({
    'folke/tokyonight.nvim',
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        styles = {
          sidebars = 'none',
          floats = 'none'
        }
      })
      vim.cmd[[colorscheme tokyonight]]
    end
  })

  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require('notify').setup({
        background_colour = "#000000"
      })
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  use({
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          hide_root_folder = true,
        },
      })
      vim.keymap.set('n', '<C-l>', ':NvimTreeToggle<CR>')
    end,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  })
end)

