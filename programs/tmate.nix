{ ... }: {
  tmate = {
    enable = true;

    extraConfig = ''
      # Fixes the delay in helix/vim when hitting esc
      set -s escape-time 0

      # Increase tmux message display duration
      set -g display-time 4000

      # Upgrade $TERM
      set -g default-terminal "tmux-256color"

      # Enable terminal focus events
      set -g focus-events on
    '';
  };
}
