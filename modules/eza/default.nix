{ ... }:
{
  programs.eza = {
    enable = true;
    extraOptions = [
      "--no-permissions"
      "--git"
      "--header"
      "--group-directories-first"
      "--no-user"
      "--time-style=long-iso"
    ];
  };
}
