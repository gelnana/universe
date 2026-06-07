{
  home = {
    lib,
    host,
    ...
  }: {
    programs.dank-material-shell.settings = {
      launchPrefix = "uwsm-app --";
      gtkThemingEnabled = false;
      qtThemingEnabled = false;

      blurredWallpaperLayer = true;

      dockTransparency = lib.mkForce 0.25;

      widgetBackgroundColor = "s";

      launcherLogoMode = "os";
      launcherLogoSizeOffset = 10;

      # dock settings
      showDock = true;
      dockMargin = 10;
      dockIconSize = 40;

      # power settings
      lockBeforeSuspend = true;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;

      batteryLockTimeout = 900; # 15 minutes
      batteryMonitorTimeout = 1200; # 20 minutes
      batterySuspendTimeout = 1800; # 30 minutes
      batterySuspendBehavior = 0;

      # fingerprint
      enableFprint = host.detect.fingerprint;
      maxFprintTries = 15;

      # u2f
      greeterEnableU2f = host.tags.include ? yubikey;

      cursorSettings = {
        theme = "System Default";
        size = 24;
        niri = lib.mkIf (host.tags.include ? niri) {
          hideWhenTyping = true;
          hideAfterInactiveMs = 0;
        };
      };

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          visible = true;

          position = 0; # Top
          autoHide = false;
          autoHideDelay = 250;
          openOnOverview = false;
          showOnLastDisplay = true;
          screenPreferences = ["all"];

          noBackground = false;
          transparency = 0;
          widgetTransparency = 0.85;
          spacing = 4;
          innerPadding = -4;
          bottomGap = 1;
          squareCorners = false;
          fontScale = 1;

          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;

          borderEnabled = false;
          borderColor = "secondary";
          borderOpacity = 0.6;
          borderThickness = 1;

          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;

          popupGapsAuto = true;
          popupGapsManual = 4;

          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          rightWidgets =
            [
              "systemTray"
              "clipboard"
              "usbManager"
            ]
            ++ lib.optional (host.tags.include ? kde-connect) "dankKDEConnect"
            ++ [
              "notificationButton"
            ]
            ++ lib.optional (host.tags.include ? laptop) "battery"
            ++ [
              "controlCenterButton"
            ];
        }
      ];
    };
  };
}
