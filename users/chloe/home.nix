{pkgs, ...}: {
  home.packages = [
    pkgs.zathura
    # pkgs.libreoffice-fresh
    pkgs.hunspell
    pkgs.qbittorrent
    pkgs.aria2
  ];

  userspace = {
    # preferred applications
    xdg = {
      associations."application/pdf" = ["org.pwmt.zathura.desktop"];
      browser = ["zen-beta.desktop"];
      audio = ["mpv.desktop"];
      video = ["mpv.desktop"];
      text = ["Helix.desktop"];
      image = ["imv-dir.desktop"];
      torrent = ["org.qbittorrent.qBittorrent.desktop"];
    };
  };

  # folders to sync across hosts
  sync.folders = {
    Documents = "staggered";
    Projects = "staggered";
    Music = "trashcan";
    Pictures = "trashcan";
    Notes = {
      id = "4i434-3g62k";
      path = "~/Notes";
      devices = ["ukaliq" "uppik" "noteair3c"];
    };
  };
}
