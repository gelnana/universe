{
  home = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [pkgs.unstable.rust-analyzer];

    programs.helix.languages = {
      language-server.rust-analyzer.command = lib.getExe pkgs.unstable.rust-analyzer;
      language = [
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };

    programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
    ];
  };
}
