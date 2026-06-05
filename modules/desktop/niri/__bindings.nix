{
  home = {
    config,
    lib,
    ...
  }: let
    acts = config.lib.niri.actions;
    dms-ipc = acts.spawn "dms" "ipc" "call";
    move-to-ws = ws: {move-column-to-workspace = ws;};

    compositorBinds =
      [
        {
          key = "Mod+Backspace";
          action = acts.spawn "wlogout";
        }
        {
          key = "Mod+Shift+Q";
          action = acts.close-window;
        }
        {
          key = "Print";
          action.screenshot = {};
        }
        {
          key = "Shift+Print";
          action.screenshot-window = {};
        }

        # Column navigation
        {
          key = "Mod+Bracketleft";
          action = acts.focus-column-first;
        }
        {
          key = "Mod+Bracketright";
          action = acts.focus-column-last;
        }
        {
          key = "Mod+Shift+Bracketleft";
          action = acts.move-column-to-first;
        }
        {
          key = "Mod+Shift+Bracketright";
          action = acts.move-column-to-last;
        }

        # Workspace movement
        {
          key = "Mod+Ctrl+K";
          action = acts.move-workspace-up;
        }
        {
          key = "Mod+Ctrl+J";
          action = acts.move-workspace-down;
        }

        # Monitor management
        {
          key = "Mod+I";
          action = acts.focus-monitor-left;
        }
        {
          key = "Mod+O";
          action = acts.focus-monitor-right;
        }
        {
          key = "Mod+Shift+I";
          action = acts.move-workspace-to-monitor-left;
        }
        {
          key = "Mod+Shift+O";
          action = acts.move-workspace-to-monitor-right;
        }

        # Workspace switching
        {
          key = "Mod+Tab";
          action = acts.focus-workspace-previous;
        }

        # Window consumption
        {
          key = "Mod+Shift+Comma";
          action = acts.consume-or-expel-window-left;
        }
        {
          key = "Mod+Shift+Period";
          action = acts.consume-or-expel-window-right;
        }

        # Window sizing
        {
          key = "Mod+F";
          action = acts.maximize-column;
        }
        {
          key = "Mod+Shift+F";
          action = acts.fullscreen-window;
        }
        {
          key = "Mod+E";
          action = acts.center-column;
        }

        # Manual resizing
        {
          key = "Mod+R";
          action = acts.switch-preset-column-width;
        }
        {
          key = "Mod+Minus";
          action = acts.set-column-width "-10%";
        }
        {
          key = "Mod+Plus";
          action = acts.set-column-width "+10%";
        }
        {
          key = "Mod+Shift+Minus";
          action = acts.set-window-height "-10%";
        }
        {
          key = "Mod+Shift+Plus";
          action = acts.set-window-height "+10%";
        }

        # Floating windows
        {
          key = "Mod+Ctrl+V";
          action = acts.switch-focus-between-floating-and-tiling;
        }
        {
          key = "Mod+Shift+V";
          action = acts.toggle-window-floating;
        }

        # Toggle tabbed
        {
          key = "Mod+T";
          action = acts.toggle-column-tabbed-display;
        }
      ]
      ++ lib.concatMap
      (d: [
        {
          key = "Mod+${d.arrow}";
          action = d.focus;
        }
        {
          key = "Mod+${d.vim}";
          action = d.focus;
        }
        {
          key = "Mod+Shift+${d.arrow}";
          action = d.move;
        }
        {
          key = "Mod+Shift+${d.vim}";
          action = d.move;
        }
      ])
      [
        {
          arrow = "Left";
          vim = "H";
          focus = acts.focus-column-or-monitor-left;
          move = acts.move-column-left-or-to-monitor-left;
        }
        {
          arrow = "Right";
          vim = "L";
          focus = acts.focus-column-or-monitor-right;
          move = acts.move-column-right-or-to-monitor-right;
        }
        {
          arrow = "Up";
          vim = "K";
          focus = acts.focus-window-or-workspace-up;
          move = acts.move-window-up-or-to-workspace-up;
        }
        {
          arrow = "Down";
          vim = "J";
          focus = acts.focus-window-or-workspace-down;
          move = acts.move-window-down-or-to-workspace-down;
        }
      ]
      ++ lib.concatMap (
        id: let
          key =
            if id == 10
            then "0"
            else toString id;
        in [
          {
            key = "Mod+${key}";
            action = acts.focus-workspace id;
          }
          {
            key = "Mod+Shift+${key}";
            action = move-to-ws id;
          }
        ]
      ) (lib.range 1 10);

    appBinds =
      map (b: {
        inherit (b) key;
        action =
          if b.ipc != null
          then builtins.foldl' (f: f) dms-ipc b.ipc
          else builtins.foldl' (f: f) acts.spawn b.command;
      })
      config.userspace.binds;
  in {
    programs.niri.settings.binds = lib.listToAttrs (
      map (x: {
        name = x.key;
        value.action = x.action;
      }) (compositorBinds ++ appBinds)
    );
  };
}
