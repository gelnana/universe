{lib, ...}: {
  vhost = svc: domain:
    lib.optionalAttrs (!(svc.local or false)) {
      "${svc.caddy_name}.${domain}".extraConfig = ''
        bind tailscale/${svc.caddy_name}
        reverse_proxy 127.0.0.1:${toString svc.port}
      '';
    };
}
