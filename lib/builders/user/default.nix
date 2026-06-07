{
  lib,
  super,
  ...
}: {
  evalRecords = types: names: all:
    lib.genAttrs names (u: all.${u})
    |> lib.mapAttrs (name: super.records types name);

  mkHomes = {
    version,
    inputs',
    inputs,
    records,
    tags,
    select,
  }:
    lib.filterAttrs (_: u: u.role != "system") records
    |> lib.mapAttrs (_: user: let
      userTags = {
        include = tags.include // user.tags.include;
        exclude = tags.exclude // user.tags.exclude;
      };
    in
      super.home {
        inherit version user inputs' inputs;
        modules = select userTags;
      });

  mkUsers = {
    records,
    daemons ? {},
  }: let
    normal = lib.filterAttrs (_: u: u.role != "system") records;
  in [
    {
      pkgs,
      config,
      self,
      ...
    }: {
      options.groups = lib.mkOption {
        description = "user groups to collect";
        default = [];
        type = lib.types.listOf lib.types.str;
      };

      config = {
        users.groups = lib.mapAttrs (_: _: {}) (normal // daemons);
        users.users =
          lib.mapAttrs (name: u: super.account name u pkgs config.groups) normal
          // lib.mapAttrs (name: cfg: super.daemon name cfg pkgs []) daemons;

        # service specific directories to persist
        persist.storage.directories = lib.concatLists (
          lib.mapAttrsToList (name: cfg:
            lib.optional (cfg.dir != null) {
              directory =
                if cfg.dir.path != null
                then cfg.dir.path
                else "/var/lib/${name}";
              user = name;
              group = name;
              mode = cfg.dir.mode;
            })
          daemons
        );

        # any secrets used by service
        age.secrets = lib.mergeAttrsList (
          lib.mapAttrsToList (name: cfg:
            lib.listToAttrs (map (s: {
                name = s;
                value = {
                  rekeyFile = self + "/secrets/master/${s}.age";
                  owner = name;
                  mode = "0400";
                };
              })
              cfg.secrets))
          daemons
        );
      };
    }
  ];
}
