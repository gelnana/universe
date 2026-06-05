{
  tags = ["niri"];
  nixos = {
    nix.settings = {
      extra-substituters = ["https://vicinae.cachix.org"];
      extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
    };
  };

  home = {
    inputs,
    inputs',
    ...
  }: {
    imports = [inputs.vicinae.homeManagerModules.default];

    services.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        faviconService = "twenty";
        font.size = 11;
        popToRootOnClose = false;
        rootSearch.searchFiles = false;
        theme = {
          dark.name = "stylix";
          light.name = "stylix";
        };
        window = {
          csd = true;
          rounding = 10;
        };
        providers.applications.preferences.launchPrefix = "uwsm app -- ";
      };
      extensions = let
        exts = inputs'.vicinae-extensions.packages;
      in [
        exts.nix
        exts.mullvad
        exts.wifi-commander
        exts.ssh
      ];
    };

    userspace.binds = [
      {
        key = "Mod+D";
        command = [
          "vicinae"
          "toggle"
        ];
      }
    ];
  };
}
