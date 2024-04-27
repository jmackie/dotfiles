{ pkgs, ... }:
let
  nnn = pkgs.nnn.override ({ withNerdIcons = true; });
  plugins-src = (pkgs.fetchFromGitHub {
    owner = "jarun";
    repo = "nnn";
    rev = "v4.9";
    sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
  }) + "/plugins";
in
{
  programs.nnn = {
    enable = true;
    package = nnn;
    plugins.src = plugins-src;
    plugins.mappings = {
      f = "fzcd";
      r = "gitroot";
    };
  };
}
