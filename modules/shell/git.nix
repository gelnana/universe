{
  home = {
    user,
    meta,
    lib,
    ...
  }: let
    keys = meta.users.${user.name}.ssh_keys or [];
    hasKey = keys != [];
  in {
    programs.git = {
      enable = true;

      signing = lib.mkIf hasKey {
        key = "ssh-ed25519 ${builtins.head keys}";
        signByDefault = true;
        format = "ssh";
      };

      settings = {
        user.name = user.name;
        user.email = user.email;
        gpg.format = "ssh";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        credential.helper = "store";
      };
    };
  };
}
