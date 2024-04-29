{ pkgs, lib, rev, ... }: {
  nix.package = pkgs.nixVersions.nix_2_21; # pin nix version!
  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://devenv.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.extraOptions = ''
    auto-optimise-store = true
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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
