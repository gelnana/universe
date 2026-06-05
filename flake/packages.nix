_: {
  config,
  inputs,
  ...
}: let
  inherit (inputs.haumea.lib) load matchers;
  inherit (inputs.haumea.lib.transformers) liftDefault;
in {
  perSystem = {inputs', ...}: let
    prev = inputs'.nixpkgs.legacyPackages;
    stable = import inputs.nixpkgs {
      inherit (prev) system;
      config.allowUnfreePredicate = config.internal.unfree.predicate;
    };
    unstable = import inputs.nixpkgs-unstable {
      inherit (prev) system;
      config.allowUnfreePredicate = config.internal.unfree.predicate;
    };
    # custom haumea loader to apply callPackage
    call = path: stable.callPackage path {inherit prev inputs unstable;};
  in rec {
    packages = load {
      src = ../pkgs;
      loader = [(matchers.nix (_: call))];
      transformer = liftDefault;
    };

    overlayAttrs =
      packages
      // load {
        src = ../overlays;
        loader = [
          (matchers.nix (_: call))
          (matchers.extension "patch" (_: path: path))
        ];
        transformer = liftDefault;
      }
      // {inherit unstable;};
  };
}
