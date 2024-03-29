{ pkgs, inputs, ... }: {
  defaultApplications.editor = {
    cmd = "${pkgs.helix}/bin/hx";
    desktop = "helix";
  };

  home-manager.users.matthew.programs.helix = {
    enable = true;

    package = inputs.helix-trunk.packages."x86_64-linux".default;

    settings = {
      theme = "berry_blitz";

      editor = {
        scrolloff = 10;
        line-number = "relative";
        cursorline = true;
        rulers = [ 80 120 ];
        soft-wrap.enable = true;
        auto-save = true;
        bufferline = "multiple";

        file-picker = {
          hidden = false;
          git-ignore = true;
          git-global = true;
          git-exclude = true;
        };

        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [ "version-control" ];
          mode.normal = "normal";
          mode.insert = "insert";
          mode.select = "select";
        };

        cursor-shape.insert = "bar";

        lsp.display-inlay-hints = true;
      };

      keys = {
        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };

        normal = {
          "A-~" = "switch_to_uppercase";

          # Swap default behaviour for yank-on-deletion.
          "A-d" = "delete_selection";
          "d" = "delete_selection_noyank";
          "A-c" = "change_selection";
          "c" = "change_selection_noyank";
        };
      };
    };

    languages = {
      language-server.ruby-lsp = with pkgs; {
        command = "${ruby-lsp}/bin/ruby-lsp";
      };

      language-server.rust-analyzer = with pkgs; {
        command = "${rust-analyzer}/bin/rust-analyzer";
        config = {
          cargo.features = "all";
          procMacro.enable = true;
        };
      };

      language = [
        {
          name = "ruby";
          language-servers = [ "ruby-lsp" ];
        }
        {
          name = "bash";
          shebangs = [ "sh" "bash" "bats" "dash" "zsh" ];
        }
      ];
    };

    # This is the boo_berry theme but without a background colour so that
    # I can keep my transparent kitty bg.
    # Original: https://github.com/helix-editor/helix/blob/master/runtime/themes/boo_berry.toml
    themes.berry_blitz = {
      attribute = { fg = "lilac"; };
      comment = { fg = "berry_desaturated"; };
      constant = { fg = "gold"; };
      diagnostic = { modifiers = [ "underlined" ]; };
      "diff.delta" = { fg = "gold"; };
      "diff.minus" = { fg = "bubblegum"; };
      "diff.plus" = { fg = "mint"; };
      error = { fg = "bubblegum"; };
      function = { fg = "mint"; };
      "function.macro" = { fg = "bubblegum"; };
      hint = { fg = "lilac"; };
      info = { fg = "lilac"; };
      keyword = { fg = "bubblegum"; };
      label = { fg = "gold"; };
      "markup.bold" = { modifiers = [ "bold" ]; };
      "markup.heading" = { fg = "gold"; modifiers = [ "bold" ]; };
      "markup.heading.marker" = { fg = "berry_desaturated"; };
      "markup.italic" = { modifiers = [ "italic" ]; };
      "markup.link.text" = { fg = "violet"; };
      "markup.link.url" = { fg = "violet"; modifiers = [ "underlined" ]; };
      "markup.list" = { fg = "bubblegum"; };
      "markup.quote" = { fg = "berry_desaturated"; };
      "markup.raw" = { fg = "mint"; };
      module = { fg = "lilac"; };
      namespace = { fg = "lilac"; };
      operator = { fg = "bubblegum"; };
      punctuation = { fg = "lilac"; };
      string = { fg = "gold"; };
      tag = { fg = "gold"; };
      type = { fg = "violet"; };
      "ui.cursor" = { bg = "lilac"; fg = "berry"; };
      "ui.cursor.insert" = { bg = "mint"; fg = "berry"; };
      "ui.cursor.match" = { bg = "berry_desaturated"; fg = "berry"; };
      "ui.cursor.select" = { bg = "violet"; fg = "berry"; };
      "ui.cursorline" = { bg = "berry_dim"; fg = "lilac"; };
      "ui.help" = { bg = "berry_saturated"; fg = "lilac"; };
      "ui.linenr" = { fg = "berry_desaturated"; };
      "ui.linenr.selected" = { fg = "lilac"; };
      "ui.menu" = { bg = "berry_saturated"; fg = "lilac"; };
      "ui.menu.selected" = { bg = "berry_saturated"; fg = "mint"; };
      "ui.popup" = { bg = "berry_saturated"; fg = "lilac"; };
      "ui.selection" = { bg = "berry_saturated"; };
      "ui.statusline" = { bg = "berry_saturated"; fg = "lilac"; };
      "ui.statusline.inactive" = { bg = "berry_saturated"; fg = "berry_desaturated"; };
      "ui.statusline.insert" = { bg = "mint"; fg = "berry_saturated"; };
      "ui.statusline.normal" = { bg = "lilac"; fg = "berry_saturated"; };
      "ui.statusline.select" = { bg = "violet"; fg = "berry_saturated"; };
      "ui.text" = { fg = "lilac"; };
      "ui.text.focus" = { fg = "mint"; };
      "ui.virtual.indent-guide" = { fg = "berry_fade"; };
      "ui.virtual.ruler" = { bg = "berry_dim"; };
      "ui.virtual.whitespace" = { fg = "berry_desaturated"; };
      "ui.window" = { bg = "berry"; fg = "berry_desaturated"; };
      variable = { fg = "lilac"; };
      "variable.builtin" = { fg = "violet"; };
      warning = { fg = "gold"; };

      palette = {
        berry = "#3A2A4D";
        berry_desaturated = "#886C9C";
        berry_dim = "#47345E";
        berry_fade = "#5A3D6E";
        berry_saturated = "#2B1C3D";
        bubblegum = "#D678B5";
        gold = "#E3C0A8";
        lilac = "#C7B8E0";
        mint = "#7FC9AB";
        violet = "#C78DFC";
      };
    };
  };
}
