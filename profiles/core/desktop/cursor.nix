{ pkgs, ... }: {
  home-manager.users.matthew.home.pointerCursor = {
    enable = true;

    package = pkgs.xcursor-pro;

    name = "XCursor-Pro-Dark";
  };
}
