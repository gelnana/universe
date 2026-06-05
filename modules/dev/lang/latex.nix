{
  home = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [pkgs.texlab];

    programs.helix.languages = {
      language-server.texlab.command = lib.getExe pkgs.texlab;
      language = [
        {
          name = "latex";
          language-servers = [
            "texlab"
            "ltex-ls-plus"
          ];
          auto-format = true;
        }
      ];
    };

    programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
      james-yu.latex-workshop
    ];
  };
}
