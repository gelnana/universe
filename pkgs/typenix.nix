{
  inputs,
  stdenv,
  stdenvNoCC,
  unzip,
  patchelf,
  glibc,
  ...
}: let
  vsixDrv = inputs.typenix.packages.${stdenv.hostPlatform.system}.vscode-extension;
in
  stdenvNoCC.mkDerivation {
    name = "typenix-vscode-extension";
    inherit (vsixDrv) version;
    src = vsixDrv;
    nativeBuildInputs = [unzip patchelf];
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      unzip -q $src/typenix.vsix -d tmp
      mkdir -p $out/share/vscode/extensions
      mv tmp/extension $out/share/vscode/extensions/ryanrasti.typenix
      patchelf --set-interpreter ${glibc}/lib/ld-linux-x86-64.so.2 \
        $out/share/vscode/extensions/ryanrasti.typenix/lib/typenix
      runHook postInstall
    '';
    passthru = {
      vscodeExtPublisher = "ryanrasti";
      vscodeExtName = "typenix";
      vscodeExtUniqueId = "ryanrasti.typenix";
    };
  }
