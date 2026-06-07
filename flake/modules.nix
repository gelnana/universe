{lib, ...}: {
  config,
  inputs,
  ...
}: let
  inherit (inputs) haumea;
  inherit (inputs.haumea.lib) matchers loaders;
  inherit (lib.my) utils;
in {
  config._module.args = let
    # ☙🙤🙥- MODULES -🙧🙦❧
    modules = let
      modules' = haumea.lib.load {
        src = ../modules;
        loader = with haumea.lib; [(matchers.nix loaders.scoped)];
        transformer = haumea.lib.transformers.liftDefault;
        inputs = {inherit inputs lib;};
      };
    in
      utils.mapLeaves (utils.validateModule config.systems) modules';

    predicate = field: pkg: utils.extract field modules |> builtins.elem (lib.getName pkg);
  in {
    inherit modules;
    nixcfg = {
      allowUnfreePredicate = predicate "unfree";
      allowInsecurePredicate = predicate "insecure";
    };
  };
}
