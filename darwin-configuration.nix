{ pkgs, rev, ... }: {
  nix.enable = false;

  environment.systemPackages = [
    # home-manager currently has issues adding things to `~/Applications`
    # https://github.com/nix-community/home-manager/issues/1341
    pkgs.wezterm
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Set git commit hash for darwin-version.
  system.configurationRevision = rev;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
