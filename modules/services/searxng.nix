{
  tags = ["searxng"];

  nixos = {
    config,
    meta,
    host,
    self,
    ...
  }: let
    svc = meta.searxng.${host.name};
    meili = meta.meilisearch.${host.name};
    domain = meta.tailscale_domain;
  in {
    age.secrets.searxng-env = {
      rekeyFile = self + "/secrets/master/searxng-env.age";
      mode = "0400";
      owner = "searx";
    };

    services.searx = {
      enable = true;
      environmentFile = config.age.secrets.searxng-env.path;
      redisCreateLocally = true;
      settings = {
        use_default_settings = true;
        default_doi_resolver = "sci-hub.se";

        general = {
          privacypolicy_url = false;
          enable_metrics = true;
          debug = false;
        };

        ui = {
          query_in_title = true;
          center_alignment = true;
          results_on_new_tab = false;
          url_formatting = "pretty";
          hotkeys = "vim";
          theme_args.simple_style = "auto";
        };

        server = {
          port = builtins.fromJSON svc.port;
          bind_address = "127.0.0.1";
          base_url = "https://${svc.caddy_name}.${domain}/";
          image_proxy = true;
          public_instance = false;
          limiter = false;
          secret_key = "$SEARX_SECRET_KEY";
        };

        search = {
          safe_search = 0;
          formats = [
            "html"
            "json"
            "rss"
          ];
          autocomplete = "google";
          default_lang = "all";
        };

        engines = [
          {
            name = "meilisearch";
            engine = "meilisearch";
            url = "http://127.0.0.1:${meili.port}";
            api_key = "$MEILI_MASTER_KEY";
            shortcut = "ms";
            categories = "general";
            disabled = false;
          }
        ];

        enabled_plugins = [
          "Basic Calculator"
          "Hash plugin"
          "Infinite scroll"
          "Open Access DOI rewrite"
          "Hostnames plugin"
          "Unit converter plugin"
          "Tracker URL remover"
        ];
      };
    };

    services.caddy.virtualHosts."${svc.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${svc.port}
      '';
    };
  };
}
