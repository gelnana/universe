{lib, ...}: types: name: def:
(lib.evalModules {
  modules = [
    types.user.settings
    (import def.default {})
    {
      inherit (def) home;
      inherit name;
    }
  ];
}).config
