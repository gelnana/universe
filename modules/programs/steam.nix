{
  tags = [
    "steam"
    "gaming"
    "all"
  ];

  nixpkgs.unfree = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
    "corefonts"
  ];

  nixos = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = false;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    programs.gamemode.enable = true;
  };

  home = _: {
    xdg.associations."x-scheme-handler/steam" = ["steam.desktop"];
    compositor.window-rules = [
      {
        matches = [
          {app-id = "steam";}
          {title = "^notificationtoasts_\\d+_desktop$";}
        ];

        open-floating = true;
        open-focused = false;
        default-floating-position = {
          x = 15;
          y = 15;
          relative-to = "bottom-right";
        };
      }
    ];
  };
}
