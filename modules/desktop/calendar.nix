{
  tags = ["calendar"];

  home = {
    config,
    pkgs,
    ...
  }: {
    accounts.calendar = {
      basePath = "${config.home.homeDirectory}/.local/share/calendars";
      accounts."default" = {
        remote = {
          type = "caldav";
          url = "https://calendar.tail02b28f.ts.net/";
          userName = "radicale";
          passwordCommand = ["echo" "radicale"];
        };
        vdirsyncer = {
          enable = true;
          collections = ["from a"];
          metadata = ["color" "displayname"];
        };
        khal = {
          enable = true;
          type = "discover";
        };
      };
    };

    programs.khal = {
      enable = true;
      locale = {
        timeformat = "%H:%M";
        dateformat = "%Y-%m-%d";
        datetimeformat = "%Y-%m-%d %H:%M";
      };
    };

    programs.vdirsyncer.enable = true;

    systemd.user.services.vdirsyncer-sync = {
      Unit = {
        Description = "vdirsyncer calendar sync";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
      };
      Install.WantedBy = ["multi-user.target"];
    };
  };
}
