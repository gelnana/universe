{
  tags = ["niri"];
  home = {
    lib,
    user,
    config,
    ...
  }: {
    xdg = {
      mimeApps = let
        browser = [
          "application/json"
          "application/x-extension-htm"
          "application/x-extension-html"
          "application/x-extension-shtml"
          "application/x-extension-xht"
          "application/x-extension-xhtml"
          "application/xhtml+xml"
          "text/html"
          "x-www-browser"
          "x-scheme-handler/about"
          "x-scheme-handler/ftp"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/unknown"
        ];

        audio = [
          "audio/aac"
          "audio/flac"
          "audio/mpeg"
          "audio/ogg"
          "audio/opus"
          "audio/wav"
          "audio-x-ms-wma"
        ];

        image = [
          "image/avif"
          "image/bmp"
          "image/gif"
          "image/heic"
          "image/jpeg"
          "image/png"
          "image/svg+xml"
          "image/tiff"
          "image/webp"
          "image/x-icon"
        ];

        text = [
          "text/csv"
          "text/plain"
        ];

        torrent = [
          "x-scheme-handler/magnet"
          "x-scheme-handler/x-bittorrent"
        ];

        video = [
          "video/mp4"
          "video/ogg"
          "video/quicktime"
          "video/webm"
          "video/x-matroska"
          "video/x-msvideo"
          "video/x-ms-wmv"
        ];
        associations = lib.mergeAttrsList [
          config.userspace.xdg.associations
          (lib.genAttrs browser (_: config.userspace.xdg.browser))
          (lib.genAttrs torrent (_: config.userspace.xdg.torrent))
          (lib.genAttrs text (_: config.userspace.xdg.text))

          (lib.genAttrs audio (_: config.userspace.xdg.audio))
          (lib.genAttrs image (_: config.userspace.xdg.image))
          (lib.genAttrs video (_: config.userspace.xdg.video))
        ];
      in {
        enable = true;

        associations.added = associations;
        defaultApplications = associations;
      };
      userDirs = {
        enable = true;
        createDirectories = true;
        documents = "/home/${user.name}/Documents";
        download = "/home/${user.name}/Downloads";
        music = "/home/${user.name}/Music";
        pictures = "/home/${user.name}/Pictures";
        videos = "/home/${user.name}/Videos";
        extraConfig = {
          SCREENSHOTS = "/home/${user.name}/Pictures/Screenshots";
        };
      };
    };
  };
}
