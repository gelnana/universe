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
    lib,
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
        inherit (svc) port;

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

    networking.firewall.allowedTCPPorts = lib.optional (svc.local or false) svc.port;
    services.caddy.virtualHosts = lib.my.services.vhost svc domain;
  };
}
