{
  tags = ["suwayomi"];
  daemons.suwayomi = {
    uid = 2004;
    dir = {
      path = "/var/lib/suwayomi-server";
      mode = "0750";
    };
  };
  nixos = {
    meta,
    host,
    ...
  }: let
    svc = meta.suwayomi.${host.name};
    domain = meta.tailscale_domain;
  in {
    systemd.tmpfiles.rules = [
      "d /var/lib/suwayomi-server/.local 0755 suwayomi suwayomi -"
      "d /var/lib/suwayomi-server/.local/share 0755 suwayomi suwayomi -"
      "d /var/lib/suwayomi-server/.local/share/Tachidesk 0700 suwayomi suwayomi -"
    ];

    services.suwayomi-server = {
      enable = true;
      settings.server = {
        ip = "127.0.0.1";
        port = builtins.fromJSON svc.port;

        initialOpenInBrowserEnabled = false;
        systemTrayEnabled = false;

        downloadAsCbz = true;
        autoDownloadNewChapters = true;
        excludeEntryWithUnreadChapters = false;
        autoDownloadIgnoreReUploads = false;

        excludeUnreadChapters = false;
        excludeNotStarted = false;
        excludeCompleted = false;
        globalUpdateInterval = 6;
        updateMangas = true;

        authMode = "none";
        jwtAudience = "suwayomi.lan";

        extensionRepos = [
          "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        ];
        maxSourcesInParallel = 20;
      };
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${svc.port}
      '';
    };
  };
}
