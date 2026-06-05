{lib, ...}: {
  config,
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.haumea.lib) load matchers loaders;
  inherit (lib.my) builders types;

  # ☙🙤🙥- META -🙧🙦❧
  meta = builtins.fromTOML (builtins.readFile ../meta.toml);

  # ☙🙤🙥- USERS -🙧🙦❧
  users = load {
    src = ../users;
    loader = [(matchers.nix loaders.path)];
  };

  # ☙🙤🙥- HOSTS -🙧🙦❧
  mkHost = name: host: let
    inherit (config.internal) modules;
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
    withSystem settings.system ({inputs', ...}: let
      # home-manager config per user
      homes = builders.user.mkHomes {
        inherit (settings) tags version;
        inherit inputs' inputs records;
        select = userTags:
          (builders.select modules {
            tags = userTags;
            inherit (settings) system;
          }).home;
      };
      # specialArgs for nixos module evaluation
      specialArgs = {
        inherit inputs' inputs meta;
        self' = inputs.self;
        # host settings + context for modules (name, homes, users)
        host =
          settings
          // {
            inherit name homes;
            users = lib.filterAttrs (_: u: u.role != "system") records;
          };
      };
    in
      builders.host.evalHost {
        inherit specialArgs homes selected records settings name host;
        inherit (inputs) nixpkgs;
        overlays = [config.flake.overlays.default];
        unfree = config.internal.unfree.predicate;
      });
in {
  config.internal = {
    inherit meta users;
    hosts =
      load {
        src = ../hosts;
        loader = [(matchers.nix loaders.path)];
      }
      |> lib.mapAttrs mkHost;
  };
}
