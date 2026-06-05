{lib, ...}: let
  # true if v is a leaf module node
  isLeaf = v:
    builtins.isAttrs v
    && (
      v ? tags
      || (v ? nixos && v.nixos != null)
      || (v ? home && v.home != null)
    );

  # recursively apply fn to every leaf in tree, collecting results
  walk = fn: tree:
    if isLeaf tree
    then fn tree
    else lib.concatMap (walk fn) (lib.attrValues tree);

  # map fn over leaves, preserving tree structure
  mapLeaves = fn: tree:
    if isLeaf tree
    then fn tree
    else lib.mapAttrs (_: mapLeaves fn) tree;

  # validate a module against the module type with given default systems
  validateModule = defaults: m:
    (lib.evalModules {
      modules = [
        (lib.my.types.module {defaultSystems = defaults;})
        {config = m;}
      ];
    })
    .config;

  # collect all unique sorted tag names across the tree
  index = tree:
    walk (m: lib.attrNames m.tags) tree
    |> lib.unique
    |> lib.sort lib.lessThan;

  # collect values of field from nixpkgs attrs across all leaves
  extract = field: tree:
    walk (m: m.nixpkgs.${field} or []) tree;
in {
  inherit
    # keep-sorted start
    extract
    index
    isLeaf
    mapLeaves
    validateModule
    walk
    # keep-sorted end
    ;
}
