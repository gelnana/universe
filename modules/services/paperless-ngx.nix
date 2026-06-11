{
  tags = ["paperless-ngx"];

  nixos = {
    config,
    lib,
    self,
    meta,
    host,
    ...
  }: let
    svc = meta.paperless-ngx.${host.name};
    domain = meta.tailscale_domain;
  in {
    persist.storage.directories = ["/var/lib/paperless"];

    age.secrets.paperless-admin-password = {
      rekeyFile = self + "/secrets/master/paperless-admin-password.age";
      owner = "paperless";
      mode = "0400";
    };

    services.paperless = {
      enable = true;
      inherit (svc) port;
      address = "127.0.0.1";
      domain = "${svc.caddy_name}.${domain}";
      passwordFile = config.age.secrets.paperless-admin-password.path;
      settings.PAPERLESS_OCR_OUTPUT_TYPE = "pdf";
    };

    networking.firewall.allowedTCPPorts = lib.optional (svc.local or false) svc.port;
    services.caddy.virtualHosts = lib.my.services.vhost svc domain;
  };
}
