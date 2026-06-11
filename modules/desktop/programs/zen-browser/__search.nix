{
  home = {user, ...}: {
    programs.zen-browser.profiles.${user.name}.search = {
      force = true;
      default = "SearXNG";
      engines = {
        "SearXNG" = {
          urls = [
            {
              template = "https://search.tail02b28f.ts.net/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@s"];
        };
        "Github" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@gh"];
        };
        "Searchix" = {
          urls = [
            {
              template = "https://search.nix.ee";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@nix"];
        };
        "Nixpkgs" = {
          urls = [
            {
              template = "https://search.nix.ee/packages/nixpkgs/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@nixpkgs"];
        };
        "Noogle" = {
          urls = [
            {
              template = "https://docs.nix.ee/q/";
              params = [
                {
                  name = "term";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@noogle"];
        };
        "Kernel" = {
          urls = [
            {
              template = "https://www.kernel.org/doc/html/latest/search.html";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@kernel"];
        };
        "Youtube" = {
          urls = [
            {
              template = "https://www.youtube.com/results";
              params = [
                {
                  name = "search_query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@yt"];
        };
      };
    };
  };
}
