{ pkgs, ... }:
let
  hx-split = pkgs.callPackage ../../scripts/hx-split { };
  nnn = pkgs.nnn.override ({ withNerdIcons = true; });
  nnn-wrapped = pkgs.symlinkJoin {
    name = "nnn-wrapped";
    paths = [ nnn ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/nnn --set NNN_OPENER ${hx-split}/bin/hx-split";
  };
in
{
  programs.nnn = {
    enable = true;
    package = nnn-wrapped;
  };
}
