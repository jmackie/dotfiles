{ ... }: {
  home.stateVersion = "23.11";
  imports = [
    ./home-manager-modules/eza
    ./home-manager-modules/gh
    ./home-manager-modules/git
    ./home-manager-modules/helix
    ./home-manager-modules/nnn
    ./home-manager-modules/starship
    ./home-manager-modules/tools
    ./home-manager-modules/usql
    ./home-manager-modules/wezterm
    ./home-manager-modules/zoxide
    ./home-manager-modules/zsh
  ];
  home.sessionVariables = {
    PAGER = "less -S";
    # NOTE: I'm not sure if it's bad to have $SHELL not be an absolute path
    # but this way we make sure that $SHELL invokes whatever ends up highest in $PATH...
    SHELL = "zsh";
  };
}
