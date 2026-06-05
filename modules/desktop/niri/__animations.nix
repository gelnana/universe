{
  home = _: {
    programs.niri.settings = {
      animations = {
        workspace-switch.kind.spring = {
          damping-ratio = 0.80;
          stiffness = 523;
          epsilon = 0.0001;
        };

        window-open = {
          kind.easing = {
            duration-ms = 600;
            curve = "ease-out-expo";
          };
          custom-shader = ''
            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                float prog = niri_clamped_progress;

                vec2 start = vec2(1.0, 1.0);
                vec2 dir   = vec2(-1.0, -1.0);

                vec2  p         = coords_geo.xy;
                float norm_dist = dot(p - start, dir) / 2.0;

                vec3 coords_tex = niri_geo_to_tex * coords_geo;
                vec4 col        = texture2D(niri_tex, coords_tex.xy);
                return col * (1.0 - step(prog, norm_dist));
            }
          '';
        };

        window-close = {
          kind.easing = {
            duration-ms = 600;
            curve = "ease-out-expo";
          };
          custom-shader = ''
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                float prog = niri_clamped_progress;

                vec2 start = vec2(0.0, 0.0);
                vec2 dir   = vec2(1.0, 1.0);

                float shadow_fix = 0.01;

                vec2  p         = coords_geo.xy;
                float norm_dist = (dot(p - start, dir) - shadow_fix) / 2.0;

                vec3 coords_tex = niri_geo_to_tex * coords_geo;
                vec4 col        = texture2D(niri_tex, coords_tex.xy);
                return col * (1.0 - step(norm_dist, prog));
            }
          '';
        };

        horizontal-view-movement.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 423;
          epsilon = 0.0001;
        };

        window-movement.kind.spring = {
          damping-ratio = 0.75;
          stiffness = 323;
          epsilon = 0.0001;
        };

        window-resize = {
          kind.spring = {
            damping-ratio = 0.80;
            stiffness = 423;
            epsilon = 0.001;
          };
          custom-shader = ''
            vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
                vec3 coords_tex_next = niri_geo_to_tex_next * coords_curr_geo;
                vec4 color = texture2D(niri_tex_next, coords_tex_next.st);
                return color;
            }
          '';
        };

        config-notification-open-close.kind.spring = {
          damping-ratio = 0.65;
          stiffness = 923;
          epsilon = 0.001;
        };

        screenshot-ui-open.kind.easing = {
          duration-ms = 200;
          curve = "ease-out-quad";
        };

        overview-open-close.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
    };
  };
}
