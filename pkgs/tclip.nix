{
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule {
  pname = "tclip";
  version = "0-unstable-2026-03-09";
  src = fetchFromGitHub {
    owner = "tailscale-dev";
    repo = "tclip";
    rev = "c460fa2d9f9e91d81cd85eadae6dbc98326f3894";
    hash = "sha256-mCjc+3zTj68vuw1Fi2hALbZm1S/HcI4x+Fo3/GI1RbI=";
  };
  vendorHash = "sha256-NaytxOvg4q2vaURAbnI0wn4mT5U+J5hFWcyp00IdLeQ=";
}
