{lib, ...}: {
  config,
  inputs,
  ...
}: let
  inherit (inputs.haumea.lib) load matchers loaders;
  inherit (inputs.haumea.lib.transformers) liftDefault;
  inherit (lib.my) utils builders;
in {
  config.internal = let
    # ☙🙤🙥- MODULES -🙧🙦❧
    modules = utils.mapLeaves (utils.validateModule config.systems) (load {
      src = ../modules;
      loader = [(matchers.nix loaders.scoped)];
      transformer = liftDefault;
      inputs = {inherit inputs lib;};
    });
  in {
    inherit modules;
    tags = utils.index modules;
    unfree.packages = utils.extract "unfree" modules;
    select = builders.select modules;
  };
}
