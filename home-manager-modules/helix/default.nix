{ pkgs, helix, ... }:
{
  programs.helix = {
    enable = true;
    package = helix;
    # Bake in some useful language servers
    extraPackages = with pkgs; [
      nil # Nix language server!
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.graphql-language-service-cli
      marksman
    ];
    defaultEditor = true; # set $EDITOR
    themes = {
      jmackie_dark = {
        inherits = "dark_plus";
        "ui.background" = { }; # transparent
      };
      jmackie_light = {
        inherits = "solarized_light";
      };
    };
  };
  xdg.configFile."helix/config.toml".text = builtins.readFile ./config.toml;
}
