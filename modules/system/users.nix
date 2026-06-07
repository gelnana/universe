{
  nixos = {
    config,
    lib,
    inputs,
    inputs',
    self,
    host,
    meta,
    ...
  }: let
    mkUserSecrets = name: _u: {
      "${name}-password" = {
        rekeyFile = self + "/secrets/master/users/${name}/pass.age";
        mode = "0400";
        owner = "root";
      };
    };
  in {
    imports = [inputs.home-manager.nixosModules.home-manager];
    config = {
      users = {
        mutableUsers = false;
        users =
          lib.mapAttrs (name: _: {
            hashedPasswordFile = config.age.secrets."${name}-password".path;
            openssh.authorizedKeys.keys = builtins.map (k: "ssh-ed25519 ${k}") (
              meta.users.${name}.ssh_keys or []
            );
          })
          host.users;
      };

      age.secrets = lib.concatMapAttrs mkUserSecrets host.users;

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hm-bak";
        extraSpecialArgs = {
          inherit
            inputs
            inputs'
            self
            host
            meta
            ;
        };
        users = host.homes;
      };
    };
  };
}
