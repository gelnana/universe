let
  inherit (lib) mkOption;
  t = lib.types;
in {
  home = {pkgs, ...}: {
    options.theme = mkOption {
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
                package = mkOption {
                  type = t.package;
                  default = pkgs.nerd-fonts.fira-code;
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
                  type = t.package;
                  default = pkgs.capitaine-cursors;
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
                  type = t.package;
                  default = pkgs.tela-icon-theme;
                };
              };
            };
          };
        };
      };
    };
  };
}
