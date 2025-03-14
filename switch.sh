#!/usr/bin/env bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --show-trace --flake "$(realpath .)"
