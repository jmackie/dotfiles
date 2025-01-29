{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils
    sd
    ripgrep
    tldr
    entr
    curl
    httpie
    ctop
    cachix

    (rustPlatform.buildRustPackage rec {
      pname = "smartcat";
      version = "2.2.0";
      src = fetchFromGitHub {
        owner = "efugier";
        repo = pname;
        rev = version;
        hash = "sha256-nXuMyHV5Sln3qWXIhIDdV0thSY4YbvzGqNWGIw4QLdM=";
      };
      useFetchCargoVendor = true;
      cargoHash = "sha256-tR7+SecTS1FWwcPF25PclT6lEjY9NUEj/2EBhbgg0tw=";
    })
  ];
  programs.bat.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fzf.enable = true;
  programs.jq.enable = true;
}
