{ lib, symlinkJoin, makeWrapper }: { program, env ? { }, flags ? [ ] }:
let
  inherit (lib) length mapAttrsToList concatStringsSep optionals;
  exe = lib.getExe program;
  bin = builtins.baseNameOf exe;
  setArgs = mapAttrsToList (key: value: "--set ${key} ${value}") env;
  addFlagsArgs = optionals (length flags > 0) [ "--add-flags \"${concatStringsSep " " flags}\"" ];
  args = concatStringsSep " " (setArgs ++ addFlagsArgs);
in
symlinkJoin
{
  name = "${bin}-wrapped";
  meta.mainProgram = bin;
  paths = [ program ];
  preferLocalBuild = true;
  nativeBuildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${bin} ${args}";
}
