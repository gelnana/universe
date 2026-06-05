{
  tags = [
    "homepage"
  ];

  nixos = {
    meta,
    host,
    ...
  }: let
    domain = meta.tailscale_domain;
    hub = meta.homepage.${host.name};
  in {
    services.homepage-dashboard = {
      enable = true;
      listenPort = builtins.fromJSON hub.port;
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
                siteMonitor = "http://127.0.0.1:${meta.calibre-web.${host.name}.port}";
              };
            }
            {
              "Suwayomi" = {
                href = "https://${meta.suwayomi.${host.name}.caddy_name}.${domain}";
                description = meta.suwayomi.${host.name}.description;
                icon = meta.suwayomi.${host.name}.icon;
                siteMonitor = "http://127.0.0.1:${meta.suwayomi.${host.name}.port}";
              };
            }
            {
              "Radicale" = {
                href = "https://${meta.radicale.${host.name}.caddy_name}.${domain}";
                description = meta.radicale.${host.name}.description;
                icon = meta.radicale.${host.name}.icon;
                siteMonitor = "http://127.0.0.1:${meta.radicale.${host.name}.port}";
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
                siteMonitor = "http://127.0.0.1:${meta.searxng.${host.name}.port}";
              };
            }
            {
              "Paperless-ngx" = {
                href = "https://${meta.paperless-ngx.${host.name}.caddy_name}.${domain}";
                description = meta.paperless-ngx.${host.name}.description;
                icon = meta.paperless-ngx.${host.name}.icon;
                siteMonitor = "http://127.0.0.1:${meta.paperless-ngx.${host.name}.port}";
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

    services.caddy.virtualHosts."${hub.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${hub.caddy_name}
        reverse_proxy 127.0.0.1:${hub.port}
      '';
    };

    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [(builtins.fromJSON hub.port)];
  };
}
