{
  home = {
    lib,
    meta,
    ...
  }: let
    domain = meta.tailscale_domain;
    caddy_names =
      lib.concatMap
      (per_host:
        lib.optionals (builtins.isAttrs per_host)
        (lib.catAttrs "caddy_name" (lib.attrValues per_host)))
      (lib.attrValues meta);
  in {
    programs.zen-browser.profiles.default.bookmarks =
      map (name: {
        inherit name;
        keyword = name;
        url = "https://${name}.${domain}";
      })
      caddy_names;
  };
}
