{lib, ...}: name: cfg: pkgs: _groups: {
  isSystemUser = true;
  uid = lib.mkDefault cfg.uid;
  group = lib.mkDefault name;
  shell = lib.mkDefault pkgs.bash;
  home = lib.mkDefault "/var/empty";
}
