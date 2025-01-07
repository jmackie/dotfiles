#!/usr/bin/env bash
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin -- switch --show-trace --flake "$(realpath .)"
