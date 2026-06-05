{
  super,
  inputs,
  ...
}: {
  tags = ["niri"];

  nixpkgs.overlays = [inputs.niri.overlays.niri];

  nixos = {pkgs, ...}: {
    nix.settings = {
      extra-substituters = ["https://niri.cachix.org"];
      trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="];
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  home = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      inputs.niri.homeModules.niri
      super.bindings.home
      super.rules.home
      super.settings.home
      super.animations.home
    ];

    home.packages = [
      pkgs.grim
      pkgs.slurp
      pkgs.wlogout
      pkgs.cliphist
      pkgs.satty
      pkgs.xwayland-satellite
    ];
  };
}
