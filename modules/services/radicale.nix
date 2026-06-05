{
  tags = ["radicale"];
  daemons.radicale = {
    uid = 2002;
    dir.mode = "0700";
    secrets = ["google-client-id" "google-client-secret"];
  };
  nixos = {
    config,
    pkgs,
    meta,
    host,
    ...
  }: let
    svc = meta.radicale.${host.name};
    domain = meta.tailscale_domain;
  in {
    services.radicale = {
      enable = true;
      settings = {
        server.hosts = ["127.0.0.1:${svc.port}"];
        auth.type = "none";
        storage.filesystem_folder = "/var/lib/radicale/collections";
      };
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${svc.port}
      '';
    };

    environment.etc."vdirsyncer/calendar.cfg" = {
      mode = "0400";
      user = "radicale";
      text = ''
        [general]
        status_path = "/var/lib/radicale/status"

        [pair google_radicale]
        a = "google"
        b = "radicale"
        collections = ["from a"]
        metadata = ["color", "displayname"]

        [storage google]
        type = "google_calendar"
        token_file = "/var/lib/radicale/google_token"
        client_id.fetch = ["command", "cat", "${config.age.secrets."google-client-id".path}"]
        client_secret.fetch = ["command", "cat", "${config.age.secrets."google-client-secret".path}"]

        [storage radicale]
        type = "caldav"
        url = "http://127.0.0.1:${svc.port}/"
        username = "radicale"
        password = "radicale"
      '';
    };

    systemd.services.vdirsyncer-calendar = {
      description = "Sync Google Calendar to Radicale";
      after = ["radicale.service" "network-online.target"];
      wants = ["network-online.target"];
      serviceConfig = {
        ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer -c /etc/vdirsyncer/calendar.cfg sync";
        User = "radicale";
        Type = "oneshot";
      };
    };

    systemd.timers.vdirsyncer-calendar = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "*:0/5";
        Persistent = true;
      };
    };
  };
}
