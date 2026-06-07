{
  nixos = {pkgs, ...}: {
    stylix = {
      # ☙🙤🙥- FONTS -🙧🙦❧
      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };

  home = {config, ...}: {
    stylix = {
      # ☙🙤🙥- FONTS -🙧🙦❧
      fonts = {
        monospace = {
          package = config.theme.font.package;
          name = config.theme.font.name;
        };
        sizes = {
          terminal = config.theme.font.size;
          applications = config.theme.font.size;
        };
      };
    };
  };
}
