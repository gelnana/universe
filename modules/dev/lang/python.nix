{
  home = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      pkgs.unstable.basedpyright
      pkgs.unstable.ruff
    ];

    programs.helix.languages = {
      language-server.basedpyright = {
        command = "${pkgs.unstable.basedpyright}/bin/basedpyright-langserver";
        args = ["--stdio"];
      };
      language-server.ruff = {
        command = lib.getExe pkgs.unstable.ruff;
        args = ["server"];
      };
      language = [
        {
          name = "python";
          language-servers = [
            "basedpyright"
            "ruff"
          ];
          auto-format = true;
        }
      ];
    };

    programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
      # ms-python.python
      charliermarsh.ruff
      ms-toolsai.jupyter
    ];
  };
}
