{
  tags = ["calibre-web"];
  daemons.calibre-web = {
    uid = 2000;
    dir = {
      path = "/var/lib/calibre-web-automated";
      mode = "0750";
    };
  };
  nixos = {
    meta,
    host,
    ...
  }: let
    svc = meta.calibre-web.${host.name};
    domain = meta.tailscale_domain;
  in {
    systemd.tmpfiles.rules = [
      "d /calibre           0750 calibre-web calibre-web -"
      "d /cwa-book-ingest   0775 calibre-web calibre-web -"
    ];

    virtualisation.oci-containers.containers.calibre-web-automated = {
      image = "crocodilestick/calibre-web-automated:latest";
      ports = ["127.0.0.1:${svc.port}:8083"];
      extraOptions = ["--no-healthcheck"];
      volumes = [
        "/var/lib/calibre-web-automated:/config"
        "/calibre:/calibre-library"
        "/cwa-book-ingest:/cwa-book-ingest"
      ];
      environment = {
        PUID = "2000";
        PGID = "2000";
        TZ = "America/Vancouver";
        REVERSE_PROXY_AUTH_HEADER = "true";
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
