{
  tags = [
    "vscode"
    "dev"
    "all"
  ];

  home = {pkgs, ...}: {
    programs.vscodium = {
      enable = true;
      profiles.default = {
        userSettings = {
          "workbench.iconTheme" = "vscode-icons";
          "editor.minimap.renderCharacters" = false;
          "direnv.restart.automatic" = true;
          "gitlens.plusFeatures.enabled" = false;
        };
        extensions = with pkgs.vscode-extensions; [
          mkhl.direnv
          esbenp.prettier-vscode
          aaron-bond.better-comments
          timonwong.shellcheck
          vscodevim.vim
          yzhang.markdown-all-in-one
          eamodio.gitlens
          vscode-icons-team.vscode-icons
          tailscale.vscode-tailscale
        ];
      };
    };
  };
}
