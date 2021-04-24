#!/usr/bin/env bash

set -e

shopt -s extglob

usage () {
  printf "%b\n" \
    "\e[4mUsage\e[0m: $(basename $0) [OPTS] PACKAGE\n" \
    "\e[4mOptions\e[0m:"

  printf "  %-30s %s\n\n" \
  "--commit" "Commit the update with an appropriate commit message" \
  "--review" "Validate this and all dependent packages"
}

case "$1" in
  ""|"-h"|"help"|*(-)"help")
    usage
    ;;

  "-c"|*(-)"commit")
    shift 1
    nix-update --commit --test --format ${@}
    ;;

  "-r"|*(-)"review")
    shift 1
    nix-update --review --test --format ${@}
    ;;

  *)
    nix-update --test --format ${@}
    ;;
esac
