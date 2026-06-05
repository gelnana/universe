{lib, ...}: types: name: path:
(lib.evalModules {
  modules = [
    types.host.settings
    (import path {})
    {config.deployment.targetHost = lib.mkDefault name;}
  ];
}).config
