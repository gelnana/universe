{
  prev,
  fetchFromGitHub,
  rustPlatform,
  ...
}:
prev.statix.overrideAttrs (_o: rec {
  # https://github.com/oppiliappan/statix/issues/139#issuecomment-3418399235
  src = fetchFromGitHub {
    owner = "oppiliappan";
    repo = "statix";
    rev = "43681f0da4bf1cc6ecd487ef0a5c6ad72e3397c7";
    hash = "sha256-LXvbkO/H+xscQsyHIo/QbNPw2EKqheuNjphdLfIZUv4=";
  };
  cargoDeps = rustPlatform.importCargoLock {
    lockFile = src + "/Cargo.lock";
    allowBuiltinFetchGit = true;
  };
})
