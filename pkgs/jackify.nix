# shamelessly ripped from https://github.com/ctknightdev/nixos/blob/c4590fb7c459ac2c14afcdb0775b62c1bd3454cb/pkgs/jackify.nix
{
  appimageTools,
  fetchurl,
  lib,
  ...
}: let
  version = "0.5.0.4";
  pname = "Jackify";
  id = "com.jackify.app";

  src = fetchurl {
    url = "https://github.com/Omni-guides/Jackify/releases/download/v${version}/${pname}.AppImage";
    hash = "sha256-IQtWDX3njHqJhJzBFc7DmWJy9Du+F7RadN74SAl6X/U=";
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs: (with pkgs; [
      icu
      python3
      zstd
    ]);

    extraInstallCommands = ''
      install -Dm444 ${appimageContents}/${id}.desktop -t $out/share/applications
      install -Dm444 ${appimageContents}/${id}.png -t $out/share/pixmaps
    '';

    meta = {
      description = "A modlist installation and configuration tool for Wabbajack modlists on Linux";
      homepage = "https://github.com/Omni-guides/Jackify";
      license = lib.licenses.gpl3Plus;
      maintainers = with lib.maintainers; [legit228];
      platforms = lib.platforms.linux;
    };
  }
