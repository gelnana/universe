{
  tags = ["pihole"];

  nixos = {
    config,
    self,
    meta,
    host,
    ...
  }: let
    svc = meta.pihole.${host.name};
    domain = meta.tailscale_domain;
  in {
    systemd.tmpfiles.rules = [
      "d /var/lib/pihole        0755 root root -"
      "d /var/lib/pihole-dnsmasq.d 0755 root root -"
    ];

    age.secrets.pihole-webpassword = {
      rekeyFile = self + "/secrets/master/pihole-webpassword.age";
      mode = "0400";
    };

    virtualisation.oci-containers.containers.pihole = {
      image = "pihole/pihole:latest";
      environmentFiles = [config.age.secrets.pihole-webpassword.path];
      environment = {
        TZ = "America/Vancouver";
        FTLCONF_webserver_port = "${toString svc.port}o";
      };
      extraOptions = ["--network=host"];
      volumes = [
        "/var/lib/pihole:/etc/pihole"
        "/var/lib/pihole-dnsmasq.d:/etc/dnsmasq.d"
      ];
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy ${host.name}.${domain}:${toString svc.port}
      '';
    };
  };
}
