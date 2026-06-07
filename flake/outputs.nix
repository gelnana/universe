{lib, ...}: {
  config,
  inputs,
  ...
}: {
  flake = {
    inherit lib;

    # ☙🙤🙥- NIXOS -🙧🙦❧
    nixosConfigurations =
      config.internal.hosts
      |> lib.mapAttrs (_: cfg:
        lib.nixosSystem {
          inherit (cfg) specialArgs;
          modules = cfg.nixosModules;
        });

    # ☙🙤🙥- HOME MANAGER -🙧🙦❧
    homeConfigurations =
      config.internal.hosts
      |> lib.concatMapAttrs (hostname: cfg:
        cfg.homes
        |> lib.mapAttrs' (username: homeModule: {
          name = "${username}@${hostname}";
          value = inputs.home-manager.lib.homeManagerConfiguration {
            inherit (cfg) pkgs;
            modules = [homeModule];
            extraSpecialArgs = cfg.specialArgs;
          };
        }));

    # ☙🙤🙥- DISKO -🙧🙦❧
    diskoConfigurations =
      config.internal.hosts
      |> lib.filterAttrs (_: cfg: cfg.settings.specs.disk != null)
      |> lib.mapAttrs (name: _: config.flake.nixosConfigurations.${name}.config.disko);

    # ☙🙤🙥- COLMENA -🙧🙦❧
    colmenaHive = inputs.colmena.lib.makeHive ({
        meta = {
          nixpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          nodeSpecialArgs = lib.mapAttrs (_: cfg: cfg.specialArgs) config.internal.hosts;
        };
      }
      // lib.mapAttrs (_: cfg: {
        deployment = cfg.settings.deployment;
        imports = cfg.nixosModules;
      })
      config.internal.hosts);

    # ☙🙤🙥- ANDROID -🙧🙦❧
    androidImages = {
      jabberwocky = inputs.robotnix.lib.robotnixSystem {
        flavor = "grapheneos";
        device = "cheetah";
        apps.fdroid.enable = true;
      };
    };
  };
}
