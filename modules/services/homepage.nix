{
  tags = [
    "homepage"
  ];

  nixos = {
    lib,
    meta,
    host,
    ...
  }: let
    domain = meta.tailscale_domain;
    hub = meta.homepage.${host.name};
    siteMonitor = svc: "http://127.0.0.1:${toString svc.port}";
  in {
    services.homepage-dashboard = {
      enable = true;
      listenPort = hub.port;
      allowedHosts = "${hub.caddy_name}.${domain}";

      widgets = [
        {
          datetime = {
            text_size = "xl";
            format = {
              dateStyle = "long";
              timeStyle = "short";
              hour12 = false;
            };
          };
        }
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "/";
            label = "natseq";
            expanded = true;
            units = "metric";
            refresh = 3000;
          };
        }
        {
          search = {
            provider = "custom";
            url = "https://${meta.searxng.${host.name}.caddy_name}.${domain}/search?q=";
            target = "_blank";
          };
        }
      ];

      services = [
        {
          "Services" = [
            {
              "Calibre-Web" = {
                href = "https://${meta.calibre-web.${host.name}.caddy_name}.${domain}";
                description = meta.calibre-web.${host.name}.description;
                icon = meta.calibre-web.${host.name}.icon;
                siteMonitor = siteMonitor meta.calibre-web.${host.name};
              };
            }
            {
              "Suwayomi" = {
                href = "https://${meta.suwayomi.${host.name}.caddy_name}.${domain}";
                description = meta.suwayomi.${host.name}.description;
                icon = meta.suwayomi.${host.name}.icon;
                siteMonitor = siteMonitor meta.suwayomi.${host.name};
              };
            }
            {
              "Radicale" = {
                href = "https://${meta.radicale.${host.name}.caddy_name}.${domain}";
                description = meta.radicale.${host.name}.description;
                icon = meta.radicale.${host.name}.icon;
                siteMonitor = siteMonitor meta.radicale.${host.name};
              };
            }
            {
              "tclip" = {
                href = "https://${meta.tclip.${host.name}.caddy_name}.${domain}";
                description = meta.tclip.${host.name}.description;
                icon = meta.tclip.${host.name}.icon;
                siteMonitor = "https://${meta.tclip.${host.name}.caddy_name}.${domain}";
              };
            }
            {
              "SearXNG" = {
                href = "https://${meta.searxng.${host.name}.caddy_name}.${domain}";
                description = meta.searxng.${host.name}.description;
                icon = meta.searxng.${host.name}.icon;
                siteMonitor = siteMonitor meta.searxng.${host.name};
              };
            }
            {
              "Paperless-ngx" = {
                href = "https://${meta.paperless-ngx.${host.name}.caddy_name}.${domain}";
                description = meta.paperless-ngx.${host.name}.description;
                icon = meta.paperless-ngx.${host.name}.icon;
                siteMonitor = siteMonitor meta.paperless-ngx.${host.name};
              };
            }
            {
              "Perplexica" = {
                href = "https://${meta.perplexica.ukaliq.caddy_name}.${domain}";
                description = meta.perplexica.ukaliq.description;
                icon = meta.perplexica.ukaliq.icon;
                siteMonitor = "https://${meta.perplexica.ukaliq.caddy_name}.${domain}";
              };
            }
          ];
        }
      ];

      bookmarks = [
        {
          "Nixos" = [
            {
              "Searchix" = [
                {
                  href = "https://search.nix.ee/";
                  icon = "nixos";
                }
              ];
            }
            {
              "Nixpkgs Tracker" = [
                {
                  href = "https://nixpkgs-tracker.ocfox.me/";
                  icon = "nixos";
                }
              ];
            }
            {
              "NixOS Wiki" = [
                {
                  href = "https://wiki.nixos.org";
                  icon = "nixos";
                }
              ];
            }
            {
              "Noogle" = [
                {
                  href = "https://docs.nix.ee/";
                  icon = "nixos";
                }
              ];
            }
          ];
        }
        {
          "Socials" = [
            {
              "Bluesky" = [
                {
                  href = "https://bsky.app";
                  icon = "bluesky";
                }
              ];
            }
            {
              "YouTube" = [
                {
                  href = "https://www.youtube.com";
                  icon = "youtube";
                }
              ];
            }
          ];
        }
      ];
    };

    networking.firewall.allowedTCPPorts = lib.optional (hub.local or false) hub.port;
    services.caddy.virtualHosts = lib.my.services.vhost hub domain;
  };
}
