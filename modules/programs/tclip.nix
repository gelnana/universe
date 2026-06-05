{
  tags = ["tclip"];

  home = {
    pkgs,
    meta,
    ...
  }: let
    tclip-share = pkgs.writeShellApplication {
      name = "tclip-share";
      runtimeInputs = [pkgs.wl-clipboard pkgs.tclip pkgs.cliphist];
      runtimeEnv.TCLIP_BACKEND_URL = "https://${meta.tclip.natseq.caddy_name}.${meta.tailscale_domain}";
      text = ''
        content=$(cliphist list 2>/dev/null | head -1 | cliphist decode 2>/dev/null || true)
        if [ -z "$content" ]; then dms ipc call toast info "Clipboard is empty"; exit 1; fi

        url=$(printf '%s' "$content" | tclip)
        if [ -n "$url" ]; then
          printf '%s' "$url" | wl-copy
          dms ipc call toast infoWith "tclip" "$url" "" ""
        else
          dms ipc call toast error "Upload failed"
          exit 1
        fi
      '';
    };
  in {
    home.packages = [tclip-share];

    userspace.binds = [
      {
        key = "Mod+Shift+C";
        command = ["tclip-share"];
      }
    ];
  };
}
