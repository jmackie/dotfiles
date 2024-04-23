#!/usr/bin/env bash
nix run nix-darwin -- switch --show-trace --flake "$(realpath .)"
