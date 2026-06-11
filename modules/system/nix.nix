{
  nixos = {
    inputs,
    pkgs,
    ...
  }: {
    # fast file lookups (using comma)
    imports = [inputs.nix-index-database.nixosModules.nix-index];

    nix = {
      # alternative to cppNix ☆⋆｡𖦹°‧★
      package = pkgs.lixPackageSets.latest.lix;

      # pin nixpkgs entry to flake input
      registry.nixpkgs.flake = inputs.nixpkgs;

      # silences the voices; point NIX_PATH → nixpkgs.
      nixPath = ["nixpkgs=flake:nixpkgs"];

      settings = {
        system-features = [
          "nixos-test" # VM tests
          "kvm" # Hardware acceleration in VMs
          "big-parallel" # hardware is certified baller, needed by libreoffice
        ];

        experimental-features = [
          "flakes" # ❆
          "nix-command" # literally 'nix'
          "lix-custom-sub-commands" # literally 'lix'
          "cgroups" # allow nix to manage system resources using cgroups
          "auto-allocate-uids" # no more nixbld accounts during build
          "pipe-operator" # `<|` & `|>`
        ];

        # isolate build from host filesystem
        sandbox = true;

        # packages die and nix keeps building
        keep-going = true;

        # maximise concurrent build jobs, kill laptop
        max-jobs = "auto";

        # let GC clean old build outputs + derivations
        keep-outputs = false;
        keep-derivations = false;

        # symlink identical files in nix store
        auto-optimise-store = true;

        # don't let flakes overwrite my nix settings
        accept-flake-config = false;

        # don't warn about uncommitted changes
        warn-dirty = false;

        # enforce XDG-compliant locations for ~/.nix-[profile,defexpr]
        use-xdg-base-directories = true;

        # https://nlewo.github.io/nixos-manual-sphinx/administration/control-groups.xml.html
        use-cgroups = true;

        allowed-users = [
          "root"
          "@wheel"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];

        substituters = [
          # keep-sorted start
          "https://cache.nixos.org?priority=10"
          "https://gelnana.cachix.org"
          "https://nix-community.cachix.org"
          # keep-sorted end
        ];
        trusted-public-keys = [
          # keep-sorted start
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "gelnana.cachix.org-1:8YX44+Ljcz5c2UZYyVcltAzZUUcACnd2aopstzFy9gs="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # keep-sorted end
        ];
      };
    };
  };

  home = {inputs, ...}: {
    imports = [inputs.nix-index-database.homeModules.nix-index];
    programs.nix-index-database.comma.enable = true;
    programs.nix-index.enable = true;
  };
}
