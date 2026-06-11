{
  tags = ["nushell"];

  home = {
    lib,
    pkgs,
    ...
  }: {
    programs = {
      nushell = {
        enable = true;
        package = pkgs.unstable.nushell;

        environmentVariables = {
          EDITOR = "hx";
          PROMPT_INDICATOR_VI_INSERT = "";
          PROMPT_INDICATOR_VI_NORMAL = "";
        };

        shellAliases = {
          ls = "eza";
          ll = "eza -l --git";
          la = "eza -la --git";
          lt = "eza --tree";

          ca = "colmena apply --on";
          cb = "colmena build --on";

          nos = "nh os switch";
          nob = "nh os build";

          gs = "git status";
          gd = "git diff";
          gl = "git log --oneline";

          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";

          wake-ukaliq = "^ssh emrys@sila.tail02b28f.ts.net wakeonlan d8:43:ae:78:ab:2f";
        };

        extraConfig = ''
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/git/git-completions.nu *
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/nix/nix-completions.nu *
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/rg/rg-completions.nu *
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/ssh/ssh-completions.nu *
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/zoxide/zoxide-completions.nu *
          use ${pkgs.unstable.nu_scripts}/share/nu_scripts/custom-completions/eza/eza-completions.nu *

          def u [...args: string] {
            with-env { NIXPKGS_ALLOW_UNFREE: "1" } {
              let rest = ($args | skip 1)
              if ($args.0 | str starts-with "nix") {
                run-external $args.0 "--impure" ...$rest
              } else {
                run-external $args.0 ...$rest
              }
            }
          }

        '';

        settings = {
          show_banner = false;
          edit_mode = "vi";
          buffer_editor = "hx";
          use_kitty_protocol = true;
          bracketed_paste = true;
          error_style = "fancy";
          recursion_limit = 50;

          history = {
            file_format = "sqlite";
            max_size = 5000000;
            sync_on_enter = true;
            isolation = true;
          };

          cursor_shape = {
            vi_insert = "block";
            vi_normal = "underscore";
          };

          completions = {
            algorithm = "fuzzy";
            sort = "smart";
            quick = true;
            partial = true;
            external = {
              enable = true;
              max_results = 50;
              completer = lib.hm.nushell.mkNushellInline ''
                {|spans|
                  try { carapace $spans.0 nushell ...$spans | from json } catch { [] }
                }
              '';
            };
          };

          table = {
            mode = "rounded";
            index_mode = "always";
            show_empty = true;
            padding = {
              left = 1;
              right = 1;
            };
          };

          shell_integration.reset_application_mode = true;

          datetime_format.normal = "%m/%d/%y %I:%M:%S%p";
        };
      };

      carapace = {
        enable = true;
        package = pkgs.unstable.carapace;
        enableNushellIntegration = true;
      };
    };
  };
}
