{lib, ...}: let
  t = lib.types // lib.my.types;
in
  {
    config,
    inputs,
    withSystem,
    modules,
    nixcfg,
    ...
  }: let
    inherit (inputs) self haumea;
    inherit (lib.my) builders types;

    # ☙🙤🙥- META -🙧🙦❧
    meta = builtins.fromTOML (builtins.readFile ../meta.toml);

    # ☙🙤🙥- USERS -🙧🙦❧
    users = haumea.lib.load {
      src = ../users;
      loader = with haumea.lib; [(matchers.nix loaders.path)];
    };

    mkHost = name: host: let
      # typed + validated host settings
      settings = builders.host.evalSettings types name host.settings;
      # user definitions
      records = builders.user.evalRecords types settings.users users;
      # modules to apply to this host/user
      selected = builders.select modules {
        inherit (settings) tags system;
      };
    in
      # resolve system-dependent context
      withSystem settings.system ({
        inputs',
        self',
        ...
      }: let
        # specialArgs for nixos module evaluation
        specialArgs = {
          inherit inputs inputs' self self' meta lib;
          # host settings + context for modules
          host =
            settings
            // {
              inherit name homes;
              # generate alias to retrieve facter detected system attributes
              detect = config.flake.nixosConfigurations.${name}.config.specs.detect;
              users = lib.filterAttrs (_: u: u.role != "system") records;
            };
        };
        # home-manager config per user w/ tagged modules
        homes = builders.user.mkHomes {
          inherit (settings) tags version;
          inherit inputs' inputs records;
          select = selected:
            (builders.select modules {
              tags = selected;
              inherit (settings) system;
            }).home;
        };
      in
        builders.host.evalHost {
          inherit specialArgs homes selected records settings name host;
          inherit (inputs) nixpkgs;
          overlays = [config.flake.overlays.default];
          inherit nixcfg;
        });
  in {
    # ☙🙤🙥- HOSTS -🙧🙦❧
    options.internal.hosts = lib.mkOption {
      type = t.lazyAttrsOf t.host;
      description = "per-host eval results.";
      readOnly = true;
    };

    config.internal.hosts =
      haumea.lib.load {
        src = ../hosts;
        loader = with haumea.lib; [
          (matchers.nix loaders.path)
          (matchers.extension "json" loaders.path)
        ];
      }
      |> lib.mapAttrs mkHost;
  }
