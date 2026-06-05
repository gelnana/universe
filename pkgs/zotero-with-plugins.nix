{
  unstable,
  runCommand,
  fetchurl,
  lib,
  ...
}: let
  mkPlugin = {
    name,
    url,
    hash,
    addonId,
  }:
    runCommand name {src = fetchurl {inherit url hash;};} ''
      install -Dm644 $src $out/${addonId}.xpi
    '';

  plugins = [
    (mkPlugin {
      name = "zotero-better-bibtex";
      url = "https://github.com/retorquere/zotero-better-bibtex/releases/download/v9.0.12/zotero-better-bibtex-9.0.12.xpi";
      hash = "sha256-fyxdx4BZYzxxZiF5Tg76b1aIUyE9h/3lX+2257/5vaM=";
      addonId = "better-bibtex@iris-advies.com";
    })
    (mkPlugin {
      name = "zotseek";
      url = "https://github.com/introfini/ZotSeek/releases/download/v1.10.0/zotseek-1.10.0.xpi";
      hash = "sha256-kGhHj31PRGndHBJIu5+GwrsByRkYMG4iI5D3gUgIGoY=";
      addonId = "zotseek@zotero.org";
    })
    (mkPlugin {
      name = "zotero-better-notes";
      url = "https://github.com/windingwind/zotero-better-notes/releases/download/v3.0.3/better-notes-for-zotero.xpi";
      hash = "sha256-QnB7F4eD0bCTo3MEzPHpVGSu/1bCMb3FqIi6PUVzvnE=";
      addonId = "Knowledge4Zotero@windingwind.com";
    })
    (mkPlugin {
      name = "semantic-zotero";
      url = "https://github.com/AgiNetz/semantic-zotero/releases/download/0.2.1/semantic-zotero-0.2.1.xpi";
      hash = "sha256-ZHSCFWuCz5GJFcaSyeUai98w9+gWjQwZYzOEKTBvyhg=";
      addonId = "tomasdanis26@gmail.com";
    })
    (mkPlugin {
      name = "zotero-style";
      url = "https://github.com/MuiseDestiny/zotero-style/releases/download/5.2.3/zotero-style.xpi";
      hash = "sha256-EanDkzeDU1b8utF4tWhQtXgm6heXhtIJQY4Dx8t/xHo=";
      addonId = "zoterostyle@polygon.org";
    })
  ];
in
  unstable.zotero.overrideAttrs (old: {
    postInstall =
      (old.postInstall or "")
      + lib.concatMapStrings (p: ''
        mkdir -p "$out/lib/app/extensions"
        cp ${p}/*.xpi "$out/lib/app/extensions/"
      '')
      plugins;
  })
