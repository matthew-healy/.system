{ ... }:
{
  helix = {
    enable = true;

    languages = [
      { 
        name = "rust"; 
        auto-format = true; 
      }
      { 
        name = "nickel";
        file-types = [ "ncl" ];
        comment-token = "#";
        indent = { tab-width = 2; unit = " "; };
      }
    ];
  };
}
