{ writeShellApplication, fetchurl }: writeShellApplication {
  name = "hx-split";
  runtimeInputs = [ ];
  text = builtins.readFile ./hx-split.sh;
}
