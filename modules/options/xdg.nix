let
  inherit (lib) mkOption;
  t = lib.types;
in {
  home = _: {
    options.userspace.xdg = mkOption {
      description = "default apps and mime types";
      default = {};
      type = t.submodule {
        options = {
          associations = mkOption {
            type = t.attrsOf (t.listOf t.str);
            description = "custom mime associations";
            default = {};
          };
          browser = mkOption {
            type = t.listOf t.str;
            default = ["zen-beta.desktop"];
          };
          audio = mkOption {
            type = t.listOf t.str;
            default = ["mpv.desktop"];
          };
          video = mkOption {
            type = t.listOf t.str;
            default = ["mpv.desktop"];
          };
          text = mkOption {
            type = t.listOf t.str;
            default = ["Helix.desktop"];
          };
          image = mkOption {
            type = t.listOf t.str;
            default = ["imv-dir.desktop"];
          };
          torrent = mkOption {
            type = t.listOf t.str;
            default = ["org.qbittorrent.qBittorrent.desktop"];
          };
        };
      };
    };
  };
}
