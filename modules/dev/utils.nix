{
  nixos = {pkgs, ...}: {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 30d";
      };
    };

    environment.systemPackages = [
      pkgs.sd
      pkgs.eza
      pkgs.ripgrep
      pkgs.fd
      pkgs.fzf
      pkgs.zoxide
      pkgs.jq
      pkgs.yq
      pkgs.tldr
    ];
  };

  home = {
    config,
    user,
    ...
  }: {
    programs = {
      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/.nixos";
        clean.enable = true;
      };

      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = user.tags.include ? nushell;
        nix-direnv.enable = true;
      };

      zoxide = {
        enable = true;
        enableNushellIntegration = user.tags.include ? nushell;
        options = ["--cmd z"];
      };

      television = {
        enable = true;
        enableNushellIntegration = user.tags.include ? nushell;
        enableBashIntegration = true;
      };

      nix-search-tv = {
        enable = true;
        enableTelevisionIntegration = true;
        settings.indexes = [
          "nixpkgs"
          "home-manager"
          "nixos"
        ];
      };
    };
  };
}
