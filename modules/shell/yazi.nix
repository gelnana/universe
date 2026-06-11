{
  home = {
    config,
    pkgs,
    ...
  }: {
    programs.yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
      shellWrapperName = "y";
      enableNushellIntegration = config.programs.nushell.enable;

      # --- PLUGINS & LUA ---
      plugins = {
        inherit
          (pkgs.unstable.yaziPlugins)
          mount
          git
          lazygit
          projects
          ouch
          chmod
          starship
          time-travel
          duckdb
          ;
      };

      initLua = ''
        require("starship"):setup()
        require("projects"):setup({ save = { method = "yazi" }, notify = { enable = true } })
        require("git"):setup()
        require("duckdb"):setup()
      '';

      # --- SETTINGS ---
      settings = {
        mgr = {
          ratio = [
            1
            4
            3
          ];

          prepend_previewers =
            map
            (mime: {
              inherit mime;
              run = "ouch";
            })
            [
              "application/*zip"
              "application/x-tar"
              "application/x-bzip2"
              "application/x-7z-compressed"
              "application/x-rar"
              "application/vnd.rar"
              "application/x-xz"
              "application/xz"
              "application/x-zstd"
              "application/zstd"
              "application/java-archive"
            ];

          prepend_fetchers = [
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
        };
      };

      # --- KEYMAPS ---
      keymap.manager.prepend_keymap = [
        {
          on = ["M"];
          run = "plugin mount";
          desc = "Mount drive";
        }
        {
          on = ["C"];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod";
        }

        # DuckDB
        {
          on = [
            "g"
            "u"
          ];
          run = "plugin duckdb -ui";
          desc = "DuckDB UI";
        }
        {
          on = [
            "g"
            "o"
          ];
          run = "plugin duckdb -open";
          desc = "DuckDB open";
        }
        {
          on = "H";
          run = "plugin duckdb -1";
        }
        {
          on = "L";
          run = "plugin duckdb +1";
        }

        # Projects (P prefix)
        {
          on = [
            "P"
            "s"
          ];
          run = "plugin projects save";
          desc = "Save project";
        }
        {
          on = [
            "P"
            "l"
          ];
          run = "plugin projects load";
          desc = "Load project";
        }
        {
          on = [
            "P"
            "P"
          ];
          run = "plugin projects load_last";
          desc = "Load last";
        }
        {
          on = [
            "P"
            "d"
          ];
          run = "plugin projects delete";
        }
        {
          on = [
            "P"
            "m"
          ];
          run = "plugin projects 'merge current'";
        }

        # Time Travel (z prefix)
        {
          on = [
            "z"
            "h"
          ];
          run = "plugin time-travel --args=prev";
        }
        {
          on = [
            "z"
            "l"
          ];
          run = "plugin time-travel --args=next";
        }
        {
          on = [
            "z"
            "e"
          ];
          run = "plugin time-travel --args=exit";
        }
      ];
    };
  };
}
