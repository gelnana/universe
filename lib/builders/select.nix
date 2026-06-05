{
  lib,
  root,
  ...
}: let
  matches = {
    tags,
    system ? null,
  }: m: let
    tagged = m.tags == {} || lib.intersectAttrs m.tags tags.include != {};
    allowed = lib.intersectAttrs m.tags tags.exclude == {};
    compat = system == null || m.systems == [] || builtins.elem system m.systems;
  in
    tagged && allowed && compat;
in
  modules: {
    tags,
    system ? null,
  }: let
    active = builtins.filter (matches {inherit tags system;}) (lib.collect root.utils.isLeaf modules);
  in {
    nixpkgs.overlays = lib.concatMap (m: m.nixpkgs.overlays) active;
    daemons = lib.foldl' (a: m: a // m.daemons) {} active;
    nixos = lib.concatMap (m: m.nixos) active;
    home = lib.concatMap (m: m.home) active;
  }
