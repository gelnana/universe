{
  super,
  inputs,
  ...
}: {
  tags = [
    "zen-browser"
    "browser"
    "all"
  ];
  nixpkgs = {
    overlays = [inputs.firefox-addons.overlays.default];
    unfree = [
      "libkey-nomad"
      "tampermonkey"
    ];
  };

  home = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      inputs.zen-browser.homeModules.beta
      super.bookmarks.home
      super.containers.home
      super.extensions.home
      super.search.home
    ];

    stylix.targets.zen-browser.profileNames = ["default"];

    programs.zen-browser = {
      enable = true;

      nativeMessagingHosts = [pkgs.unstable.firefoxpwa];

      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        NewTabURL = "https://search.tail02b28f.ts.net";
      };

      profiles.default = {
        isDefault = true;

        settings = {
          "browser.startup.page" = 1;
          "browser.startup.homepage" = "https://hub.tail02b28f.ts.net";
          "browser.translations.automaticallyPopup" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.recentsearches.enabled" = false;
          "privacy.donottrackheader.enabled" = true;
          "zen.workspaces.enabled" = true;
        };
      };
    };

    userspace = {
      binds = [
        {
          key = "Mod+B";
          command = ["zen-beta"];
        }
      ];
      window-rules = [
        {
          matches = [
            {
              app-id = "^zen-beta$";
              title = "Picture-in-Picture";
            }
          ];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
          default-column-width.fixed = 480;
          default-window-height.fixed = 270;
        }
        {
          matches = [{title = "Picture in picture";}];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
        }
      ];
    };
  };
}
