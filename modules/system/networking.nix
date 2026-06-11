{
  nixos = {
    host,
    lib,
    ...
  }: {
    hardware.wirelessRegulatoryDatabase = true;

    networking.nameservers = ["1.1.1.1"];

    networking.firewall = lib.mkIf (host.tags.include ? server) {
      enable = true;
      allowedTCPPorts = [2222];
      trustedInterfaces = ["lo"];
    };

    boot = {
      kernelModules = [
        "tls"
        "tcp_bbr"
      ];
      kernel.sysctl = {
        "net.ipv4.tcp_fastopen" = 3;
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.tcp_rmem" = "4096 87380 16777216";
        "net.ipv4.tcp_wmem" = "4096 16384 16777216";
        "net.core.rmem_max" = 67108864;
        "net.core.wmem_max" = 67108864;
        "net.core.rmem_default" = 87380;
        "net.core.wmem_default" = 65536;
        "net.core.somaxconn" = 8192;
        "net.core.netdev_max_backlog" = 8192;
        "net.ipv4.tcp_base_mss" = 1024;
        "net.ipv4.tcp_mtu_probing" = 2;
        "net.ipv4.tcp_window_scaling" = 1;
        "net.ipv4.tcp_timestamps" = 1;
        "net.ipv4.tcp_sack" = 1;
        "net.ipv4.tcp_adv_win_scale" = 1;
        "net.ipv4.tcp_fin_timeout" = 15;
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
      };
    };
    groups = ["networkmanager"];
  };
}
