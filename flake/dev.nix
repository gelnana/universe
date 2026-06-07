_: {inputs, ...}: {
  perSystem = {
    system,
    pkgs,
    config,
    ...
  }: {
    # ☙🙤🙥- FORMATTER -🙧🙦❧
    pre-commit.settings.hooks.treefmt.enable = true;
    formatter = config.treefmt.build.wrapper;

    treefmt.config = {
      projectRootFile = "flake.nix";
      flakeCheck = true;
      programs = {
        deadnix.enable = true;
        alejandra.enable = true;
        prettier = {
          enable = true;
          package = pkgs.prettierd;
          settings.editorconfig = true;
        };
        keep-sorted = {
          enable = true;
          excludes = ["flake.lock"];
        };
        shfmt.enable = true;
        statix.enable = true;
      };
    };

    # ☙🙤🙥- DEV SHELL -🙧🙦❧
    devShells.default = pkgs.mkShell {
      shellHook = config.pre-commit.installationScript;
      env.AGENIX_REKEY_ADD_TO_GIT = true;
      packages = [
        # keep-sorted start
        config.agenix-rekey.package
        inputs.colmena.packages.${system}.colmena
        inputs.disko.packages.${system}.disko
        pkgs.cachix
        pkgs.nixos-anywhere
        # keep-sorted end
      ];
    };
  };
}
