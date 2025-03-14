{ ... }:

let
    name = "Jordan Mackie";
    email = "12185627+jmackie@users.noreply.github.com";
in
{
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    delta.enable = true;
    lfs.enable = true;
    ignores = [ ".helix" ];
    aliases = {
      fixup = "commit --amend --no-edit";
      shove = "push --force-with-lease";
      rebase-onto = "!sh -c 'git rebase --onto $1 $(git merge-base $1 $(git rev-parse --abbrev-ref HEAD))' -";
    };
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "jmackie";
      commit.verbose = true;

      # https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/github_id_ed25519.pub";
    };
  };
  programs.jujutsu = {
    enable = true;
    settings.user = { inherit name email; };
  };
}
