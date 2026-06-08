{
  home = {
    pkgs,
    lib,
    ...
  }: {
    programs.helix = {
      enable = true;
      package = pkgs.unstable.helix;
      extraPackages = with pkgs.unstable; [
        harper
        codebook
        scooter
      ];

      settings = {
        editor = {
          true-color = true;
          color-modes = true;
          mouse = true;
          auto-completion = true;
          auto-format = true;
          lsp.display-inlay-hints = true;
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          end-of-line-diagnostics = "hint";
          inline-diagnostics.cursor-line = "warning";
          bufferline = "multiple";
        };
        keys.normal = {
          space = {
            g = [
              ":write-all"
              ":new"
              ":insert-output lazygit >/dev/tty"
              ":set mouse false"
              ":set mouse true"
              ":buffer-close!"
              ":redraw"
              ":reload-all"
            ];
            f = [
              ":sh rm -f /tmp/unique-file"
              ":set mouse false"
              '':insert-output yazi "%{buffer_name}" --chooser-file=/tmp/unique-file''
              '':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty''
              ":open %sh{cat /tmp/unique-file}"
              ":redraw"
              ":set mouse false"
              ":set mouse true"
            ];
            s = [
              ":write-all"
              ":new"
              ":insert-output scooter >/dev/tty"
              ":set mouse false"
              ":set mouse true"
              ":buffer-close!"
              ":redraw"
              ":reload-all"
            ];
          };
        };
      };
      languages = {
        language-server.harper-ls = {
          command = lib.getExe' pkgs.unstable.harper "harper-ls";
          args = ["--stdio"];
        };
        language-server.codebook = {
          command = lib.getExe pkgs.unstable.codebook;
          args = ["lsp"];
        };
      };
    };

    xdg.desktopEntries.Helix = {
      name = "Helix";
      exec = "${pkgs.kitty}/bin/kitty ${lib.getExe' pkgs.unstable.helix "hx"}";
      icon = "helix";
      terminal = true;
      categories = [
        "Utility"
        "TextEditor"
      ];
    };
  };
}
