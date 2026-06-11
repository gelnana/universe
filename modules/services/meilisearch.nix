{
  tags = ["meilisearch"];

  nixos = {
    config,
    lib,
    meta,
    host,
    self,
    ...
  }: let
    svc = meta.meilisearch.${host.name};
    domain = meta.tailscale_domain;
  in {
    persist.storage.directories = ["/var/lib/private/meilisearch"];

    age.secrets.meilisearch-master-key = {
      rekeyFile = self + "/secrets/master/meilisearch-master-key.age";
      mode = "0400";
    };

    services.meilisearch = {
      enable = true;
      listenAddress = "127.0.0.1";
      listenPort = svc.port;
      masterKeyFile = config.age.secrets.meilisearch-master-key.path;
      settings.env = "production";
    };

    services.caddy.virtualHosts = lib.my.services.vhost svc domain;
  };
}
