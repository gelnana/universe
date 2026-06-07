{
  nixos = {pkgs, ...}: {
    stylix = {
      # ☙🙤🙥- CURSOR & ICONS -🙧🙦❧
      cursor = {
        name = "Capitaine Cursors";
        package = pkgs.capitaine-cursors;
        size = 24;
      };
      icons = {
        enable = true;
        package = pkgs.tela-icon-theme;
        light = "Tela";
        dark = "Tela";
      };
    };
  };

  home = {config, ...}: {
    stylix = {
      # ☙🙤🙥- CURSOR & ICONS -🙧🙦❧
      cursor = {
        name = config.theme.cursor.name;
        package = config.theme.cursor.package;
        size = config.theme.cursor.size;
      };
      icons = {
        enable = true;
        package = config.theme.icons.package;
        light = config.theme.icons.name;
        dark = config.theme.icons.name;
      };

      # ☙🙤🙥- OPACITY -🙧🙦❧
      opacity.applications = config.theme.opacity;
      opacity.terminal = config.theme.opacity;
    };
  };
}
