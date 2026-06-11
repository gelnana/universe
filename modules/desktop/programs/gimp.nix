{
  tags = ["gimp" "media" "all"];

  home = {pkgs, ...}: {
    home.packages = [pkgs.unstable.gimp3-with-plugins];
  };
}
