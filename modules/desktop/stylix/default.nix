{super, ...}: {
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [
      inputs.stylix.nixosModules.stylix
      super.fonts.nixos
      super.gtk.nixos
    ];

    stylix = {
      enable = true;
      autoEnable = true;
      homeManagerIntegration.autoImport = false;
      homeManagerIntegration.followSystem = false;

      # ☙🙤🙥- PALETTE -🙧🙦❧
      base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
      polarity = "dark";
    };
  };

  home = {
    inputs,
    config,
    pkgs,
    ...
  }: {
    imports = [
      inputs.stylix.homeModules.stylix
      super.gtk.home
      super.fonts.home
    ];

    stylix = {
      enable = true;
      overlays.enable = false;

      # ☙🙤🙥- PALETTE -🙧🙦❧
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme.style}.yaml";
      polarity = config.theme.polarity;
    };
  };
}
