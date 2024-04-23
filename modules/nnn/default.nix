{ pkgs, ... }:
let
  nnn = pkgs.nnn.override ({ withNerdIcons = true; });
  opener = pkgs.writeShellScriptBin "nnn-opener" (builtins.readFile ./nnn-opener.sh);
  nnnWrapped = pkgs.symlinkJoin {
    name = "nnn-wrapped";
    paths = [ nnn ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/nnn --set NNN_OPENER ${opener}/bin/nnn-opener";
  };
in
{
  programs.nnn = {
    enable = true;
    package = nnnWrapped;
  };
}
