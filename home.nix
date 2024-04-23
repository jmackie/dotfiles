{ ... }: {
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
}
