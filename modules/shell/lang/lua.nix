{
  home = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [pkgs.unstable.lua-language-server];

    programs.helix.languages = {
      language-server.lua-ls.command = lib.getExe pkgs.unstable.lua-language-server;
      language = [
        {
          name = "lua";
          language-servers = ["lua-ls"];
          auto-format = true;
        }
      ];
    };

    programs.vscodium.profiles.default.extensions = with pkgs.vscode-extensions; [
      sumneko.lua
    ];
  };
}
