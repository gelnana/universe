{
  home = {host, ...}: {
    programs.dank-material-shell = {
      plugins = {
        displayManager.enable = host.tags.include ? niri;
        niriScreenshot.enable = host.tags.include ? niri;
        niriWindows.enable = host.tags.include ? niri;
        powerUsagePlugin.enable = host.tags.include ? laptop;
        dankBatteryAlerts.enable = host.tags.include ? laptop;
        wallpaperCarousel.enable = true;
        usbManager.enable = true;
      };
    };
    compositor.binds = [
      {
        key = "Mod+W";
        ipc = [
          "wallpaperCarousel"
          "toggle"
        ];
      }
    ];
  };
}
