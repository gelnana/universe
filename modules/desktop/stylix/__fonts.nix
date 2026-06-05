{
  nixos = {
    inputs',
    pkgs,
    ...
  }: let
    sfPro = {
      package = inputs'.apple-fonts.packages.sf-pro-nerd;
      name = "SFProText Nerd Font";
    };
  in {
    stylix = {
      # ☙🙤🙥- FONTS -🙧🙦❧
      fonts = {
        serif = sfPro;
        sansSerif = sfPro;
        monospace = {
          package = inputs'.apple-fonts.packages.sf-mono-nerd;
          name = "SFMono Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
