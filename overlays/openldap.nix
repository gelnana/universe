{prev, ...}:
# https://github.com/NixOS/nixpkgs/issues/514113#issuecomment-4367102817
prev.openldap.overrideAttrs (_: {doCheck = false;})
