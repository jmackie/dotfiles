{ pkgs, lib, ... }: {
  home.stateVersion = "23.11";
  imports = [
    ./modules/eza
    ./modules/gh
    ./modules/git
    ./modules/helix
    ./modules/nnn
    ./modules/starship
    ./modules/tools
    ./modules/usql
    ./modules/wezterm
    ./modules/zsh
  ];
  home.sessionVariables = {
    PAGER = "less -S";
    # NOTE: I'm not sure if it's bad to have $SHELL not be an absolute path
    # but this way we make sure that $SHELL invokes whatever ends up highest in $PATH...
    SHELL = "zsh";
  };
}
