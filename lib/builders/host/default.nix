{
  super,
  lib,
  ...
}: let
  evalSettings = types: name: path: super.specs (super.settings types name path);

  evalHost = args @ {
    specialArgs,
    homes,
    selected,
    records,
    settings,
    name,
    host,
    nixpkgs,
    nixcfg,
    ...
  }: let
    overlays = args.overlays ++ selected.nixpkgs.overlays;
    pkgs = import nixpkgs {
      inherit (settings) system;
      inherit overlays;
      config = nixcfg;
    };

    hardware =
      [(super.detect specialArgs.host).nixos]
      ++ (
        if host ? facter
        then [
          {hardware.facter.reportPath = host.facter;}
          (super.detect specialArgs.host).facter
        ]
        else lib.optional (host ? hardware) host.hardware
      );
  in {
    inherit settings specialArgs homes pkgs;
    nixosModules = super.modules {
      inherit (host) local;
      inherit name settings overlays nixcfg;
      modules =
        hardware
        ++ selected.nixos
        ++ lib.my.builders.user.mkUsers {
          inherit records;
          inherit (selected) daemons;
        };
    };
    homeModules = selected.home;
  };
in {inherit evalHost evalSettings;}
