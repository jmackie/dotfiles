{ pkgs, ... }:
let
  usqlWrapped = pkgs.symlinkJoin
    {
      name = "usql";
      paths = [ pkgs.usql ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = "wrapProgram $out/bin/usql --set PAGER '${pkgs.pspg}/bin/pspg' --set PSPG '--style=5'";
    };
in
{
  home.packages = [
    usqlWrapped
  ];
}
