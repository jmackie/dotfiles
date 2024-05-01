{ pkgs, lib, ... }:
let
  nnn = pkgs.nnn.override ({ withNerdIcons = true; });
  plugins-src = (pkgs.fetchFromGitHub {
    owner = "jarun";
    repo = "nnn";
    rev = "v4.9";
    sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
  }) + "/plugins";
  nuke = pkgs.writeShellScriptBin "nuke" (builtins.readFile "${plugins-src}/nuke");
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
  home.sessionVariables = {
    NNN_OPENER = lib.getExe nuke;
    NNN_OPTS = "c";
  };
}
