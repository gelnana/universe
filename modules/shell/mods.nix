{
  tags = [
    "mods"
    "dev"
    "all"
  ];

  home = {
    pkgs,
    meta,
    host,
    config,
    ...
  }: let
    isHost =
      if meta.ollama ? ${host.name}
      then "127.0.0.1"
      else "ukaliq.${meta.tailscale_domain}";
  in {
    home.packages = [
      pkgs.unstable.mcp-server-filesystem
      pkgs.unstable.mcp-server-fetch
      pkgs.unstable.mcp-nixos
    ];

    programs.mods = {
      enable = true;
      settings = {
        default-api = "ollama";
        default-model = "qwen3:14b";
        status-text = "Generating...";
        theme = "charm";
        mcp-timeout = "15s";
        apis.ollama = {
          base-url = "http://${isHost}:${toString meta.ollama.ukaliq.port}";
          models = {
            "devstral:24b".max-input-chars = 100000;
            "qwen3:14b".max-input-chars = 100000;
            "qwen3.5:9b".max-input-chars = 100000;
            "deepseek-r1:14b".max-input-chars = 100000;
            "nomic-embed-text".max-input-chars = 8192;
          };
        };
        mcp-servers = {
          filesystem = {
            command = "${pkgs.unstable.mcp-server-filesystem}/bin/mcp-server-filesystem";
            args = [config.home.homeDirectory];
          };
          fetch.command = "${pkgs.unstable.mcp-server-fetch}/bin/mcp-server-fetch";
          nixos.command = "${pkgs.unstable.mcp-nixos}/bin/mcp-nixos";
        };
      };
    };
  };
}
