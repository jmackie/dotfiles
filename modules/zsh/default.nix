{ ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      alias -s {js,json,env,md,html,css,toml}=bat
      set -o vi
    '';

    shellGlobalAliases = {
      rm = "rm -vi";
      grep = "grep --color";

      # git things
      gch = "git checkout \"$(git branch --sort=-committerdate | fzf | tr -d '[:space:]')\"";
      gs = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      ga = "git add ";
      gau = "git add -u";
      gaa = "git add --all";
      gc = "git commit";
      gcm = "git commit -m";
    };
  };
}
