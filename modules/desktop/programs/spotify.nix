{
  tags = [
    "spotify"
    "media"
    "all"
  ];

  nixpkgs.unfree = [
    "spotify"
    "spicetify-stylix"
  ];

  home = {
    inputs,
    inputs',
    ...
  }: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    programs.spicetify = let
      spicePkgs = inputs'.spicetify-nix.legacyPackages;
    in {
      enable = true;
      wayland = true;
      enabledExtensions = [
        spicePkgs.extensions.adblock
        spicePkgs.extensions.keyboardShortcut
        spicePkgs.extensions.shuffle
      ];
      enabledSnippets = [
        spicePkgs.snippets.rotatingCoverart
        spicePkgs.snippets.roundedNowPlaying
        spicePkgs.snippets.roundedImages
        spicePkgs.snippets.roundedButtons
        spicePkgs.snippets.autoHideFriends
      ];
    };
  };
}
