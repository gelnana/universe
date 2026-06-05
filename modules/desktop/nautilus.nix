{
  tags = ["niri"];
  nixos = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.imv
      pkgs.nautilus
      pkgs.file-roller
      pkgs.sushi
    ];

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    services.gvfs.enable = true;
  };

  home = {config, ...}: let
    h = config.home.homeDirectory;
  in {
    home.file.".config/gtk-3.0/bookmarks".text = ''
      file://${h}/Projects Projects
      file://${h}/Pictures Pictures
      file://${h}/Documents Documents
      file://${h}/Downloads Downloads
      file://${h}/Music Music
      file://${h}/Videos Videos
      file:///mnt/natseq Shared
    '';

    userspace.xdg.associations."inode/directory" = ["org.gnome.Nautilus.desktop"];
  };
}
