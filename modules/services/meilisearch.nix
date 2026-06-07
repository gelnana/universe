{
  tags = ["meilisearch"];
  nixos = {
    config,
    meta,
    host,
    self,
    ...
  }: let
    svc = meta.meilisearch.${host.name};
    domain = meta.tailscale_domain;
  in {
    age.secrets.meilisearch-master-key = {
      rekeyFile = self + "/secrets/master/meilisearch-master-key.age";
      mode = "0400";
    };

    persist.storage.directories = ["/var/lib/private/meilisearch"];

    services.meilisearch = {
      enable = true;
      listenAddress = "127.0.0.1";
      listenPort = builtins.fromJSON svc.port;
      masterKeyFile = config.age.secrets.meilisearch-master-key.path;
      settings.env = "production";
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${svc.port}
      '';
    };
  };
}
