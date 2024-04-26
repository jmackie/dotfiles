{ writeShellApplication, fetchurl }: writeShellApplication {
  name = "nuke";
  runtimeInputs = [
    # TODO: any launcher programs nuke should use
  ];
  text = builtins.readFile (fetchurl {
    url = "https://raw.githubusercontent.com/jarun/nnn/master/plugins/nuke";
    hash = "sha256-4wFQREkQvG93MyrX3DdNT+looWaf0NkVtyQYXAiC6CM=";
  });
  excludeShellChecks = [ "SC2317" ];
}
