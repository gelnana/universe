{
  home = {
    pkgs,
    user,
    ...
  }: {
    programs.zen-browser.profiles.${user.name} = {
      extensions.packages = with pkgs.firefox-addons; [
        # keep-sorted start
        browserpass
        clearurls
        enhanced-h264ify
        floccus
        image-search-options
        karakeep
        libkey-nomad
        tampermonkey
        ublock-origin
        wayback-machine
        zotero-connector
        # keep-sorted end
      ];
      mods = let
        zenMods = {
          trackpadAnimations = "8039de3b-72e1-41ea-83b3-5077cf0f98d1";
          animationsPlus = "f4866f39-cfd6-4498-ab92-54213b8279dc";
          tidyPopup = "79dde383-4fe7-404a-a8e6-9be440022542";
          sleekBorder = "bc25808c-a012-4c0d-ad9a-aa86be616019";
          audioIndicator = "2317fd93-c3ed-4f37-b55a-304c1816819e";
        };
      in [
        zenMods.trackpadAnimations
        zenMods.animationsPlus
        zenMods.tidyPopup
        zenMods.sleekBorder
        zenMods.audioIndicator
      ];
    };
  };
}
