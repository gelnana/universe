{lib, ...}: {
  version,
  user,
  inputs',
  inputs,
  modules,
}: {
  _module.args = {
    inherit user;
    inherit inputs';
  };

  imports =
    lib.optional (user.home != null) user.home
    ++ modules
    ++ [
      inputs.wrapper-manager-fds.homeModules.wrapper-manager
      ({
        inputs',
        inputs,
        ...
      }: {
        wrapper-manager.extraSpecialArgs = {inherit inputs' inputs;};
        xdg.userDirs = {
          enable = true;
          createDirectories = true;
        };
      })
    ];

  home = {
    stateVersion = version;
    username = user.name;
    homeDirectory = "/home/${user.name}";
  };
}
