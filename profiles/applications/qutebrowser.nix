{ ... }: {
  home-manager.users.matthew.programs.qutebrowser = {
    enable = true;

    searchEngines = {
      "!g" = "https://www.google.com/search?hl=en&q={}";
      "!np" = "https://search.nixos.org/packages?channel=unstable&type=packages&query={}";
      "!w" = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
    };

    settings = {
      auto_save.session = true;

      tabs = {
        close_mouse_button = "none";

        mousewheel_switching = false;

        pinned = {
          # force pinned tabs to stay at a set URL
          frozen = true;
          # shrink pinned tabs down to min size
          shrink = true;
        };
      };
      url.start_pages = [
        # This is the default value, I just wanted to note it down so I know
        # what to change later.
        "https://start.duckduckgo.com/"
      ];
      window.transparent = true;
    };
  };
}
