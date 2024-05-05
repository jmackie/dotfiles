{ pkgs, lib, ... }:
let
  wrap = pkgs.callPackage ../../lib/wrap.nix { };
  usql-wrapped = wrap {
    program = pkgs.usql;
    env = {
      PAGER = lib.getExe pkgs.pspg;
      PSPG = "--style=5";
    };
  };
in
{
  home.packages = [
    usql-wrapped
  ];
}
