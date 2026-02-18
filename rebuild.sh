#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="/home/boris/dev/github/dotfiles"
FLAKE="$FLAKE_DIR#nixos"
NOM_FLAGS="--log-format internal-json |& nom --json"

rebuild() {
    eval "sudo nixos-rebuild $* $NOM_FLAGS"
}

case "${1:-}" in
    switch)
        # Rebuild system using current flake.lock (no input updates)
        rebuild switch --flake "$FLAKE" --impure
        ;;
    test)
        # Build and activate without updating bootloader (reverts on reboot)
        rebuild test --flake "$FLAKE" --impure
        ;;
    update)
        # Update flake inputs (nixpkgs) and rebuild system
        nix flake update --flake "$FLAKE_DIR"
        rebuild switch --flake "$FLAKE" --impure
        ;;
    diff)
        # Show what packages would change without applying
        rebuild build --flake "$FLAKE" --impure
        nix store diff-closures /run/current-system ./result
        rm -f result
        ;;
    clean)
        # Remove old generations and garbage collect the nix store
        sudo nix-collect-garbage -d
        rebuild boot --flake "$FLAKE" --impure
        ;;
    history)
        # List system generations with dates
        sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
        ;;
    *)
        echo "Usage: $0 {switch|test|update|diff|clean|history}"
        echo ""
        echo "  switch  - Rebuild system with current pinned inputs"
        echo "  test    - Build and activate without touching bootloader"
        echo "  update  - Update flake inputs then rebuild"
        echo "  diff    - Show package changes without applying"
        echo "  clean   - Delete old generations and garbage collect store"
        echo "  history - List system generations"
        exit 1
        ;;
esac
