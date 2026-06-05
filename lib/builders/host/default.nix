{
  super,
  lib,
  ...
}: let
  evalSettings = super.settings;

  evalHost = args @ {
    specialArgs,
    homes,
    selected,
    records,
    settings,
    name,
    host,
    nixpkgs,
    unfree,
    ...
  }: let
    overlays = args.overlays ++ selected.nixpkgs.overlays;
    pkgs = import nixpkgs {
      inherit (settings) system;
      inherit overlays;
      config.allowUnfreePredicate = unfree;
    };
  in {
    inherit settings specialArgs homes pkgs;
    nixosModules = super.modules {
      inherit (host) nixos hardware;
      inherit name settings pkgs;
      modules =
        selected.nixos
        ++ lib.my.builders.user.mkUsers {
          inherit records;
          inherit (selected) daemons;
        };
    };
    homeModules = selected.home;
  };
in {inherit evalHost evalSettings;}
