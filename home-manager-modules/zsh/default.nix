{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initExtra = ''
      alias -s {js,json,env,md,html,css,toml}=bat
      set -o vi
      unsetopt BEEP

      # https://martinheinz.dev/blog/110
      HISTFILE="$HOME/.zsh_history"
      HISTSIZE=10000000
      SAVEHIST=10000000
      HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
      HIST_STAMPS="yyyy-mm-dd"
      setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
      setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
      setopt SHARE_HISTORY         # Share history between all sessions.
      setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
      setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
      setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
      setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
      setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
      setopt APPEND_HISTORY        # append to history file (Default)
      setopt HIST_NO_STORE         # Don't store history commands
      setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

      # https://yazi-rs.github.io/docs/quick-start#shell-wrapper
      function y() {
    	  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    	  yazi "$@" --cwd-file="$tmp"
    	  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    	  	builtin cd -- "$cwd"
    	  fi
    	  rm -f -- "$tmp"
      }
    '';

    shellAliases = {
      rm = "rm -vi";
      grep = "grep --color";
      tree = "${lib.getExe pkgs.broot} -c :pt";

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
