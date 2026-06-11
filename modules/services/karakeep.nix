{
  tags = ["karakeep"];

  nixos = {
    config,
    lib,
    meta,
    host,
    self,
    ...
  }: let
    svc = meta.karakeep.${host.name};
    domain = meta.tailscale_domain;
  in {
    persist.storage.directories = ["/var/lib/karakeep"];

    age.secrets.karakeep-env = {
      rekeyFile = self + "/secrets/master/karakeep-env.age";
      mode = "0400";
      owner = "karakeep";
    };

    services.karakeep = {
      enable = true;
      meilisearch.enable = true;
      environmentFile = config.age.secrets.karakeep-env.path;
      extraEnvironment = {
        PORT = toString svc.port;
        # DISABLE_SIGNUPS = "true";
      };
    };

    networking.firewall.allowedTCPPorts = lib.optional (svc.local or false) svc.port;
    services.caddy.virtualHosts = lib.my.services.vhost svc domain;
  };
}
