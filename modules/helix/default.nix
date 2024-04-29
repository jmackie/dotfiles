{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    # Bake in some useful language servers
    extraPackages = with pkgs; [
      nil # Nix language server!
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
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
    settings = {
      # NOTE: the adaptive theme (file) gets created and updated by wezterm in response 
      # to system dark/light colour scheme changes
      theme = "adaptive";
      editor = {
        mouse = false;
        cursorline = true;
        auto-format = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys = {
        normal = {
          # CTRL+S to save because it's a habit I can't seem to shake
          C-s = ":write";
          G = "goto_file_end";
        };
        insert = {
          # CTRL+S to save because it's a habit I can't seem to shake
          C-s = [ ":write" "normal_mode" ];
        };
      };
    };
  };
}
