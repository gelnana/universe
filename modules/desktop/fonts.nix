{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = {pkgs, ...}: {
    fonts = {
      fontconfig.enable = true;
      fontDir.enable = true;
      packages = [
        pkgs.corefonts
        pkgs.julia-mono
        pkgs.font-awesome
        pkgs.noto-fonts
        pkgs.noto-fonts-color-emoji
        pkgs.roboto
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };
  };
}
