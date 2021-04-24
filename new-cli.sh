#!/usr/bin/env bash

set -e

shopt -s extglob

TEMPLATES=( "@TEMPLATES@" )

usage () {
  printf "%b\n" \
    "\e[4mUsage\e[0m: $(basename $0) TEMPLATE\n" \
    "\e[4mTemplates\e[0m:"

  printf "  %-30s %s\n\n" "${TEMPLATES[@]}"
}

case "$1" in
  ""|"-h"|"help"|*(-)"help")
    usage
    ;;

  *)
    nix flake new -t "@flake@#$1" "$2"
    ;;
esac
