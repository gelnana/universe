{lib, ...}:
lib.mkOption {
  type = lib.types.submodule {
    options = {
      include = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "traits to select for.";
        default = [];
      };
      exclude = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "traits to remove.";
        default = [];
      };
    };
  };
  default = {};
  # convert strings to attributes.
  apply = t: {
    include = lib.genAttrs t.include (_: true);
    exclude = lib.genAttrs t.exclude (_: true);
  };
}
