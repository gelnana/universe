{
  home = {
    config,
    pkgs,
    ...
  }: {
    programs.dsearch = {
      enable = true;
      package = pkgs.dsearch;
      config = {
        index_paths = [
          {
            path = "/home/${config.home.username}";
          }
        ];
      };
    };
  };
}
