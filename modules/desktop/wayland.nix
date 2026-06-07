{
  tags = ["niri"];
  nixos = {pkgs, ...}: {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gnome];
      config.common.default = [
        "gnome"
        "gtk"
      ];
    };

    security.polkit.enable = true;
    services.dbus.enable = true;

    qt.enable = true;

    persist.storage.directories = ["/var/lib/AccountsService"];

    environment.systemPackages = [
      pkgs.wayland-utils
      pkgs.wlr-randr
      pkgs.wl-clipboard
      pkgs.dragon-drop
    ];

    services.accounts-daemon.enable = true;
    groups = ["input" "video"];
  };
}
