{
  nixos = {
    inputs,
    config,
    pkgs,
    host,
    meta,
    self,
    ...
  }: {
    imports = [
      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
    ];

    environment.systemPackages = [pkgs.rage];

    age = {
      rekey.agePlugins = [pkgs.age-plugin-yubikey];
      identityPaths = [
        "${config.persist.storage.path}/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key"
      ];

      rekey = {
        masterIdentities = [(self + "/secrets/yubikey.pub")];
        hostPubkey = "ssh-ed25519 ${meta.hosts.${host.name}.host_pubkey}";
        storageMode = "local";
        localStorageDir = self + "/secrets/rekeyed/${host.name}";
      };
    };
  };
}
