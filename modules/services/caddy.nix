{
  tags = ["caddy"];
  daemons.caddy.uid = 239;
  nixos = {
    config,
    pkgs,
    self,
    ...
  }: {
    persist.storage.directories = ["/var/lib/caddy"];

    age.secrets.caddy-tailscale-auth = {
      rekeyFile = self + "/secrets/master/caddy-tailscale-auth.age";
      mode = "0400";
      owner = "caddy";
    };

    systemd.services.caddy = {
      after = ["agenix.service"];
      wants = ["agenix.service"];
      reloadIfChanged = false;
      serviceConfig.EnvironmentFile = config.age.secrets.caddy-tailscale-auth.path;
    };

    services.caddy = {
      enable = true;
      package = pkgs.caddy-plugins;
      globalConfig = ''
        tailscale {
          state_dir /var/lib/caddy/tailscale
        }

        servers {
          protocols h1 h2
        }
      '';
    };
  };
}
