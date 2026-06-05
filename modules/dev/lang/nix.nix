{
  home = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      pkgs.unstable.nil
      pkgs.unstable.alejandra
    ];

    programs.helix.languages = {
      language-server.nil.command = lib.getExe pkgs.unstable.nil;
      language = [
        {
          name = "nix";
          language-servers = ["nil"];
          formatter.command = lib.getExe pkgs.unstable.alejandra;
          auto-format = true;
        }
      ];
    };

    programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
    ];
  };
}
