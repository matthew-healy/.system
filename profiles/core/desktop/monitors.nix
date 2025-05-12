{ pkgs, ... }:
let
  ports = {
    laptop = "eDP-1";
    hdmi = "HDMI-A-1";
  };

  monitors = {
    dell = {
      make = "Dell Inc.";
      model = "DELL S3221QS";
    };
  };

  cmd = {
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    jq = "${pkgs.jq}/bin/jq";
    sha256sum = "${pkgs.coreutils}/bin/sha256sum";
  };

  detectMonitors = pkgs.writeShellScript "detect-monitors.sh" ''
    #!/user/bin/env bash
    set -euo pipefail

    log() {
      echo "[$(date '+%Y-%m-%d %H:%M;%S')] $*" >> ~/.cache/detect-monitors.log
    }

    readarray -t MONITORS < <(${cmd.hyprctl} monitors -j | jq -r '.[].name')

    apply_laptop_only() {
      log "Applying laptop-only layout"
      ${cmd.hyprctl} keyword monitor "${ports.laptop},preferred,0x0,1"
      ${cmd.hyprctl} keyword monitor "${ports.hdmi},disable"
    }

    apply_dell_4k() {
      log "Applying Dell 4k layout"
      ${cmd.hyprctl} keyword monitor "${ports.laptop},disable"
      ${cmd.hyprctl} keyword monitor "${ports.hdmi},3840x2160@60,0x0,1"
    }

    MONITORS_JSON=$(${cmd.hyprctl} monitors -j)

    if ! ${cmd.jq} -e ".[] | select(.name == ${ports.hdmi})" <<< "$MONITORS_JSON" > /dev/null; then
      apply_laptop_only
      exit
    fi

    MAKE=$(${cmd.jq} -r ".[] | select(.name == ${ports.hdmi}) | .make" <<< "$MONITORS_JSON")
    MODEL=$(${cmd.jq} -r ".[] | select(.name == ${ports.hdmi}) | .model" <<< "$MONITORS_JSON")

    if [[ "$MAKE" == "${monitors.dell.make}" && "$MODEL" == "${monitors.dell.model}" ]]; then
      apply_dell_4k
    else
      log "Unknown make & model: $MAKE, $MODEL"
      apply_laptop_only
    fi
  '';

  detectMonitorsWatcher = pkgs.writeShellScript "detect-monitors-watcher.sh" ''
    #!/user/bin/env bash
    set -euo pipefail

    get_monitor_state_hash() {
      ${cmd.hyprctl} monitors -j | ${cmd.jq} -S 'map({make,model,name,disabled})' | ${cmd.sha256sum} | awk '{print $1}'
    }

    PREV_HASH=""

    while true; do
      CURRENT_HASH=$(get_monitor_state_hash)
      if [[ "$CURRENT_HASH" != "$PREV_HASH" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Monitor layout detected. Applying config..."
        ${detectMonitors}
      fi
      sleep 2
    done
  '';
in
{
  environment.systemPackages = with pkgs; [ hyprland jq ];

  systemd.user.services.detect-monitors-watcher = {
    description = "Detect monitors & update layout";

    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "${detectMonitorsWatcher}";
      Restart = "always";
    };
  };

  home-manager.users.matthew.wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${detectMonitors}"
    ];
  };
}
