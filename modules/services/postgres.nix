{
  tags = ["postgresql"];

  nixos = {lib, ...}: {
    persist.storage.directories = [
      {
        directory = "/var/lib/postgresql";
        user = "postgres";
        group = "postgres";
        mode = "0700";
      }
    ];

    services.postgresql = {
      enable = true;
      enableTCPIP = true;
      enableJIT = true;

      initdbArgs = ["--locale=C.UTF-8" "--encoding=UTF8"];

      settings.password_encryption = "scram-sha-256";

      extensions = ps: [ps.pgvector];

      identMap = ''
        global postgres postgres
        global root     postgres
      '';

      authentication = lib.mkForce ''
        local all all peer map=global
        host  all all 127.0.0.1/32  scram-sha-256
        host  all all ::1/128       scram-sha-256
        host  all all 100.64.0.0/10 scram-sha-256
      '';
    };
  };
}
