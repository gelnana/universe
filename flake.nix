{
  description = ''
    𓆝 𓆟 𓆞 𓆝 𓆟𓆝 𓆟 𓆞 𓆝 𓆟𓆝 𓆟 𓆞 𓆝 𓆟𓆝 𓆟 𓆞 𓆝 𓆟 𓆝 𓆞 𓆝 𓆟
  '';
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # 🎉
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # ── Core ─────────────────────────────────────────────────────────────────
    systems.url = "github:nix-systems/default-linux";
    # <https://flake.parts/>
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # <https://nix-community.github.io/haumea/>
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Infra ─────────────────────────────────────────────────────────────────
    # <https://colmena.cli.rs/unstable/>
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://nix-community.github.io/home-manager/>
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://github.com/nix-community/disko/blob/master/docs/INDEX.md>
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html>
    impermanence.url = "github:nix-community/impermanence";
    # <https://github.com/ryantm/agenix>
    agenix.url = "github:ryantm/agenix";
    # <https://flake.parts/options/agenix-rekey>
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://github.com/nix-community/nixos-facter>
    nixos-facter.url = "github:nix-community/nixos-facter";
    # <https://foo-dogsquared.github.io/nix-module-wrapper-manager-fds/wrapper-manager-fds/project-overview.html>
    wrapper-manager-fds.url = "github:foo-dogsquared/nix-module-wrapper-manager-fds";

    # ── Dev shell ────────────────────────────────────────────────────────────
    # <https://numtide.github.io/devshell/getting_started.html>
    devshell.url = "github:numtide/devshell";
    # <https://treefmt.com/latest/>
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://pre-commit.com/index.html>
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://docs.robotnix.org/welcome.html>
    robotnix.url = "github:nix-community/robotnix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Desktop ──────────────────────────────────────────────────────────────
    # <https://nix-community.github.io/stylix/>
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # <https://niri-wm.github.io/niri/>
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # <https://docs.vicinae.com/>
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # <https://danklinux.com/docs/>
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # ── Apps / Misc ─────────────────────────────────────────────────────────────
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted start
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    musnix.url = "github:musnix/musnix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    typenix.url = "github:ryanrasti/typenix/13550ee05461121a74a6467aefc479a62026cdfc";
    # keep-sorted end
  };

  outputs = inputs @ {
    flake-parts,
    haumea,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib.extend (final: _: {
      my = haumea.lib.load {
        src = ./lib;
        loader = [(haumea.lib.matchers.nix haumea.lib.loaders.scoped)];
        inputs = {lib = final;};
        transformer = haumea.lib.transformers.liftDefault;
      };
    });
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({flake-parts-lib, ...}: {
      systems = import inputs.systems;

      imports =
        [
          # keep-sorted start
          inputs.agenix-rekey.flakeModule
          inputs.disko.flakeModule
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.flake-parts.flakeModules.nixpkgs
          inputs.git-hooks.flakeModule
          inputs.home-manager.flakeModules.home-manager
          inputs.treefmt-nix.flakeModule
          # keep-sorted end
        ]
        ++ builtins.attrValues (haumea.lib.load {
          src = ./flake;
          inputs = {inherit lib;};
          loader = {lib, ...}: path: _: flake-parts-lib.importApply path {inherit lib;};
        });
    });
}
