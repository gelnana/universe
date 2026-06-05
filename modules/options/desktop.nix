let
  inherit (lib) mkOption;
  t = lib.types;
in {
  nixos = _: {
    options = {
      userspace.groups = mkOption {
        description = "user groups to collect";
        default = [];
        type = t.listOf t.str;
      };
      device.monitors = mkOption {
        description = "monitor configs for the compositor";
        default = [];
        type = t.listOf (t.submodule {
          options = {
            name = mkOption {
              type = t.str;
              description = "output name (like eDP-1)";
            };
            scale = mkOption {
              type = t.float;
              default = 1.0;
            };
            enable = mkOption {
              type = t.bool;
              default = true;
            };
          };
        });
      };
    };
  };
  home = _: {
    options.userspace = {
      theme = mkOption {
        default = {};
        type = t.submodule {
          options = {
            style = mkOption {
              type = t.str;
              default = "kanagawa";
            };
            opacity = mkOption {
              type = t.float;
              default = 0.90;
            };
            polarity = mkOption {
              type = t.enum ["light" "dark"];
              default = "dark";
            };

            font = mkOption {
              default = {};
              type = t.submodule {
                options = {
                  name = mkOption {
                    type = t.str;
                    default = "FiraCode Nerd Font";
                  };
                  size = mkOption {
                    type = t.number;
                    default = 12.0;
                  };
                };
              };
            };

            cursor = mkOption {
              default = {};
              type = t.submodule {
                options = {
                  name = mkOption {
                    type = t.str;
                    default = "Capitaine Cursors";
                  };
                  size = mkOption {
                    type = t.ints.positive;
                    default = 24;
                  };
                  package = mkOption {
                    type = t.str;
                    default = "capitaine-cursors";
                  };
                };
              };
            };

            icons = mkOption {
              default = {};
              type = t.submodule {
                options = {
                  name = mkOption {
                    type = t.str;
                    default = "Tela";
                  };
                  package = mkOption {
                    type = t.str;
                    default = "tela-icon-theme";
                  };
                };
              };
            };
          };
        };
      };
      xdg = mkOption {
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
      binds = mkOption {
        description = "compositor keybinds";
        default = [];
        type = t.listOf (t.submodule {
          options = {
            key = mkOption {type = t.str;};
            command = mkOption {
              type = t.listOf t.str;
              default = [];
            };
            ipc = mkOption {
              type = t.nullOr (t.listOf t.str);
              default = null;
              description = "ipc args";
            };
          };
        });
      };
      window-rules = mkOption {
        description = "compositor window rules";
        default = [];
        type = t.listOf t.attrs;
      };
      layer-rules = mkOption {
        description = "compositor layer rules";
        default = [];
        type = t.listOf t.attrs;
      };
    };
  };
}
