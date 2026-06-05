{
  nixos = {
    inputs',
    lib,
    host,
    ...
  }: let
    defaultUser = builtins.head (builtins.attrNames host.users);
  in {
    services.greetd.settings.default_session.user = lib.mkDefault defaultUser;
    services.displayManager.dms-greeter = {
      enable = true;
      package = inputs'.dms.packages.default;
      compositor.name = "niri";
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
      configHome = lib.mkDefault "/home/${defaultUser}";
    };

    persist.storage.directories = ["/var/lib/dms-greeter"];
  };
}
