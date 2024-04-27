{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    sd
    ripgrep
    tldr
    entr
    curl
    httpie
    ctop
    cachix
  ];
  programs.bat.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.jq.enable = true;
}
