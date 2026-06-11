{
  tags = ["inkscape" "media" "all"];

  home = {pkgs, ...}: {
    home.packages = [pkgs.unstable.inkscape-with-extensions];
  };
}
