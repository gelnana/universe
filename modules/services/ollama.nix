{
  tags = ["ollama"];
  daemons.ai.uid = 2003;
  nixos = {
    pkgs,
    lib,
    ...
  }: {
    persist.storage.directories = ["/var/lib/private/ollama"];

    services.ollama = {
      enable = true;
      package = pkgs.unstable.ollama-rocm;
      host = "127.0.0.1";
      rocmOverrideGfx = "10.3.0";
      environmentVariables = {
        ROCR_VISIBLE_DEVICES = "0";
        OLLAMA_FLASH_ATTENTION = "1";
        OLLAMA_KEEP_ALIVE = "30m";
        OLLAMA_NUM_PARALLEL = "1";
        GPU_MAX_ALLOC_PERCENT = "100";
        GPU_SINGLE_ALLOC_PERCENT = "100";
      };
      loadModels = [
        "devstral:24b"
        "qwen3:14b"
        "deepseek-r1:14b"
        "qwen3.5:9b"
        "nomic-embed-text"
      ];
    };

    systemd.services.ollama.after = lib.mkForce ["network.target"];
  };
}
