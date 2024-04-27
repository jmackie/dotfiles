{ pkgs, lib, ... }:
let
  hx-split = pkgs.writeShellScriptBin "hx-split" (builtins.readFile ./hx-split.sh);
  nnn-wrapped = pkgs.writeShellScriptBin "nnn-wrapped" ''
    export EDITOR=${lib.getExe hx-split}
    export VISUAL=$EDITOR
    export PATH="$HOME/.config/nnn/plugins:$PATH"
    export NNN_OPENER=nuke
    exec -a "$0" nnn -c "$@"
  '';
  # nn because it's smaller than nnn, get it?
  nn = pkgs.writeShellScriptBin "nn" ''
    pane_id=$(wezterm cli split-pane --left --percent 20 ${lib.getExe nnn-wrapped})
  '';
in
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
  home.packages = [
    nn
  ];
}
