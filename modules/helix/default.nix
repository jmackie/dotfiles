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
    settings = {
      theme = "dark_plus_transparent"; # custom theme, defined below
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
    themes = {
      dark_plus_transparent = {
        inherits = "dark_plus";
        "ui.background" = { };
      };
    };
  };
}
