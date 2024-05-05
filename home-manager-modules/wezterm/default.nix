{ pkgs, lib, config, ... }:
let
  wrap = pkgs.callPackage ../../lib/wrap.nix { };
  hx-split = pkgs.writeShellScriptBin "hx-split" (builtins.readFile ./hx-split.sh);
  nnn-wrapped = wrap {
    program = config.programs.nnn.finalPackage;
    env = rec {
      EDITOR = lib.getExe hx-split;
      VISUAL = EDITOR;
    };
  };
  # nn because it's smaller than nnn, get it?
  nn = pkgs.writeShellScriptBin "nn" ''
    # wezterm echos the new pane id
    # so assign it to silence it
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
