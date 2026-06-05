{lib, ...}: {
  tags = ["syncthing"];

  nixos = _: {
    networking.firewall.allowedTCPPorts = [22000];
    networking.firewall.allowedUDPPorts = [22000];
  };

  home = {
    meta,
    host,
    user,
    config,
    ...
  }: let
    domain = meta.tailscale_domain;

    all =
      meta.syncthing
      |> lib.filterAttrs (name: cfg: name != host.name && builtins.elem user.name cfg.users)
      |> lib.attrNames;

    peers =
      all
      |> builtins.filter (name: meta.syncthing.${name}.role == "peer");

    devices = lib.genAttrs all (name: {
      id = meta.syncthing.${name}.id;
      addresses = ["tcp://${name}.${domain}:22000"];
    });
  in {
    services.syncthing = {
      enable = true;
      settings = {
        options = {
          localAnnounceEnabled = false;
          globalAnnounceEnabled = false;
          relaysEnabled = false;
          urAccepted = -1;
        };

        inherit devices;

        folders = let
          versioning = {
            staggered = {
              type = "staggered";
              params = {
                cleanInterval = "3600"; # 1 hour
                maxAge = "15552000"; # 6 months
              };
            };
            trashcan = {
              type = "trashcan";
              params.cleanoutDays = "30";
            };
          };
        in
          lib.mapAttrs (_: cfg:
            {
              inherit (cfg) path;

              devices =
                if cfg.devices != null
                then builtins.filter (d: !(builtins.isString d && d == host.name)) cfg.devices
                else peers;
            }
            // lib.optionalAttrs (cfg.id != null) {inherit (cfg) id;}
            // lib.optionalAttrs (cfg.versioning != null) {
              versioning = versioning.${cfg.versioning};
            })
          config.sync.folders;
      };
    };
  };
}
