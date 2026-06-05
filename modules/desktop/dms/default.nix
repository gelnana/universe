{super, ...}: {
  tags = ["niri"];
  nixos = {
    inputs',
    host,
    ...
  }: {
    imports = [super.greeter.nixos];

    programs.dms-shell = {
      enable = true;
      package = inputs'.dms.packages.default;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableSystemMonitoring = true;
      enableAudioWavelength = true;
      enableClipboardPaste = true;
      enableCalendarEvents = host.tags.include ? calendar;
    };
    systemd.user.services.niri-flake-polkit.enable = false;
  };

  home = {inputs, ...}: {
    imports = [
      inputs.dms.homeModules.default
      inputs.dms-plugin-registry.homeModules.default
      inputs.danksearch.homeModules.default
      super.dsearch.home
      super.settings.home
      super.plugins.home
    ];

    services.playerctld.enable = true;

    programs.dank-material-shell.enable = true;

    userspace.binds = [
      {
        key = "XF86AudioRaiseVolume";
        ipc = ["audio" "increment" "5"];
      }
      {
        key = "XF86AudioLowerVolume";
        ipc = ["audio" "decrement" "5"];
      }
      {
        key = "XF86AudioMute";
        ipc = ["audio" "mute"];
      }
    ];

    userspace = {
      window-rules = [
        {
          matches = [{app-id = "org.quickshell";}];
          open-floating = true;
        }
      ];

      layer-rules = [
        {
          matches = [{namespace = "dms:blurwallpaper";}];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
