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

  home = {
    config,
    pkgs,
    ...
  }: {
    stylix = {
      # ☙🙤🙥- CURSOR & ICONS -🙧🙦❧
      cursor = {
        name = config.userspace.theme.cursor.name;
        package = pkgs.${config.userspace.theme.cursor.package};
        size = config.userspace.theme.cursor.size;
      };
      icons = {
        enable = true;
        package = pkgs.${config.userspace.theme.icons.package};
        light = config.userspace.theme.icons.name;
        dark = config.userspace.theme.icons.name;
      };

      # ☙🙤🙥- OPACITY -🙧🙦❧
      opacity.applications = config.userspace.theme.opacity;
      opacity.terminal = config.userspace.theme.opacity;
    };
  };
}
