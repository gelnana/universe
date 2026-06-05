{
  home = {
    osConfig,
    lib,
    ...
  }: {
    programs.niri = {
      settings = {
        # map to available host monitors
        outputs = lib.listToAttrs (
          map (m: {
            inherit (m) name;
            value = {
              inherit (m) scale enable;
            };
          })
          (osConfig.device.monitors or [])
        );

        prefer-no-csd = true;
        xwayland-satellite.enable = true;

        spawn-at-startup = [
          {
            command = [
              "dbus-update-activation-environment"
              "--systemd"
              "WAYLAND_DISPLAY"
              "DISPLAY"
              "XDG_CURRENT_DESKTOP"
            ];
          }
          {
            command = [
              "wl-paste"
              "--watch"
              "cliphist"
              "store"
            ];
          }
        ];

        hotkey-overlay.skip-at-startup = true;

        input = {
          keyboard.xkb.layout = "us";

          touchpad = {
            click-method = "button-areas";
            dwt = true;
            dwtp = true;
            natural-scroll = true;
            scroll-method = "two-finger";
            tap = true;
            tap-button-map = "left-right-middle";
            middle-emulation = true;
            accel-profile = "adaptive";
          };

          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "90%";
          };

          warp-mouse-to-focus.enable = true;
          workspace-auto-back-and-forth = true;
        };

        screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

        overview = {
          zoom = 0.45;
          workspace-shadow.enable = true;
        };

        gestures.hot-corners.enable = true;

        layout = {
          background-color = "transparent";

          focus-ring.enable = false;

          border = {
            enable = true;
            width = 1;
          };

          shadow.enable = false;

          preset-column-widths = [
            {proportion = 0.25;}
            {proportion = 0.5;}
            {proportion = 0.75;}
            {proportion = 1.0;}
          ];

          always-center-single-column = true;
          default-column-width.proportion = 0.5;
          gaps = 6;
        };
      };
    };
  };
}
