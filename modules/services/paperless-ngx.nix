{
  tags = ["paperless-ngx"];
  nixos = {
    config,
    self',
    meta,
    host,
    ...
  }: let
    svc = meta.paperless-ngx.${host.name};
    domain = meta.tailscale_domain;
  in {
    persist.storage.directories = ["/var/lib/paperless"];

    age.secrets.paperless-admin-password = {
      rekeyFile = self' + "/secrets/master/paperless-admin-password.age";
      owner = "paperless";
      mode = "0400";
    };

    services.paperless = {
      enable = true;
      port = builtins.fromJSON svc.port;
      address = "127.0.0.1";
      domain = "${svc.caddy_name}.${domain}";
      passwordFile = config.age.secrets.paperless-admin-password.path;
      settings.PAPERLESS_OCR_OUTPUT_TYPE = "pdf";
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${svc.port}
      '';
    };

    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [(builtins.fromJSON svc.port)];
  };
}
