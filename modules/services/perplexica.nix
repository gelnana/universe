{
  tags = ["perplexica"];
  nixos = {
    lib,
    meta,
    host,
    ...
  }: let
    domain = meta.tailscale_domain;
    ollama = meta.ollama.${host.name};
    perplexica = meta.perplexica.${host.name};
    searxng = meta.searxng.natseq;
  in {
    persist.storage.directories = ["/var/lib/perplexica"];

    systemd.tmpfiles.rules = [
      "d /var/lib/perplexica/data    0755 root root -"
      "d /var/lib/perplexica/uploads 0755 root root -"
    ];

    virtualisation.oci-containers.containers.perplexica = {
      image = "itzcrazykns1337/perplexica:latest";
      environment = {
        SEARXNG_API_URL = "https://${searxng.caddy_name}.${domain}";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:${ollama.port}";
        PORT = perplexica.port;
      };
      volumes = [
        "/var/lib/perplexica/data:/home/perplexica/data"
        "/var/lib/perplexica/uploads:/home/perplexica/uploads"
      ];
      extraOptions = ["--network=host"];
    };

    systemd.services.podman-perplexica.serviceConfig.Type = lib.mkForce "simple";

    services.caddy.virtualHosts."${perplexica.caddy_name}.${domain}" = {
      extraConfig = ''
        bind tailscale/${perplexica.caddy_name}
        reverse_proxy 127.0.0.2:${perplexica.port}
      '';
    };
  };
}
