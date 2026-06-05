{lib, ...}: name: attrs: pkgs: groups: let
  admin = attrs.role == "admin";
in {
  isNormalUser = true;
  uid = lib.mkDefault attrs.uid;
  home = lib.mkDefault "/home/${name}";
  group = name;
  shell = pkgs.${attrs.shell} or pkgs.bash;
  extraGroups = ["users"] ++ groups ++ lib.optional admin "wheel";
}
