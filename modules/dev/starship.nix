{
  tags = [
    "laptop"
    "workstation"
  ];

  home = {
    lib,
    config,
    ...
  }: let
    inherit (config.lib.stylix) colors;
  in {
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = {
      enable = true;
      enableBashIntegration = true;

      enableNushellIntegration = config.programs.nushell.enable;

      settings = {
        add_newline = true;
        format = lib.concatStrings [
          "[](fg:#${colors.base01})"
          "$username"
          "[@](bold fg:#${colors.base04} bg:#${colors.base01})"
          "$hostname"
          "[](fg:#${colors.base01})"
          "$git_branch"
          "$directory"
          "$fill"
          "$time"
          "$line_break"
          "$character"
        ];
        right_format = "$custom";

        username = {
          format = "[$user]($style)";
          show_always = true;
          style_user = "bold fg:#${colors.base06} bg:#${colors.base01}";
          style_root = "bold fg:#${colors.base0F} bg:#${colors.base01}";
        };

        hostname = {
          ssh_only = false;
          ssh_symbol = " 󰖈";
          format = "[$hostname]($style)[$ssh_symbol](bold fg:#${colors.base0D})";
          style = "bold fg:#${colors.base04} bg:#${colors.base01}";
          disabled = false;
        };

        directory = {
          format = "[](fg:#${colors.base01})[$path]($style)[$read_only]($read_only_style)[](fg:#${colors.base01})";
          home_symbol = "";
          read_only = " 󰈈";
          read_only_style = "bold fg:#${colors.base0A} bg:#${colors.base01}";
          style = "fg:#${colors.base0C} bg:#${colors.base01}";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = " ";
            "Downloads" = " ";
            "Music" = "󰎈 ";
            "Pictures" = " ";
            "Data" = "󰲋 ";
            "Videos" = " ";
          };
        };
        git_branch = {
          symbol = "  ";
          style = "bg:#${colors.base01}";
          truncation_length = 4;
          truncation_symbol = "…";
          format = "[](fg:#${colors.base01})[$symbol $branch(:$remote_branch)](fg:#${colors.base0B} $style)[](fg:#${colors.base01})";
        };

        character = {
          success_symbol = "[ \\(◡◕⩊◕\\)ᑐ—⊹](bold fg:#${colors.base0E})[⠁⭒*.](bold fg:#${colors.base0A})";
          error_symbol = "[ \\(◡.‸.\\)ᑐ—⊹](bold fg:#${colors.base0D})[⠁⭒*.](bold fg:#${colors.base0A})";
          format = "$symbol[✩ ](bold fg:#${colors.base0A})";
        };

        fill = {
          symbol = " ";
        };

        time = {
          disabled = false;
          time_format = "%R";
          format = "[](bold fg:#${colors.base01})[](fg:#${colors.base0D} bg:#${colors.base01})[ $time](bg:#${colors.base01} fg:#${colors.base03})[](fg:#${colors.base01})";
        };
      };
    };
  };
}
