{ ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    nixpkgs-fmt.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
    taplo.enable = true;
  };
}
