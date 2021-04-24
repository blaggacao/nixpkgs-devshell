#!/usr/bin/env bash

set -e

shopt -s extglob

usage () {
  printf "%b\n" \
    "\e[4mUsage\e[0m: $(basename $0) [OPTS] COMMAND\n" \
    "\e[4mOptions\e[0m:"

  printf "  %-30s %s\n\n" \
  "--system" "review for a different architecure"

  printf "\n\e[4mCommands\e[0m:\n"

  printf "  %-30s %s\n\n" \
  "unstaged" "review unstaged changes" \
  "staged" "review staged changes"
}

opts=()

while [ "$#" -gt 0 ]; do
  i="$1"; shift 1
  case "$i" in
    ""|"-h"|"help"|*(-)"help")
      usage
      exit 0
      ;;

    "-s"|*(-)"system")
      j="$1"; shift 1
      opts+=("--system" "$j")
      ;;

    "unstaged")
      nixpkgs-review "${opts[@]}" wip
      exit 0
      ;;

    "staged")
      nixpkgs-review "${opts[@]}" wip --staged
      exit 0
      ;;

    *)
      usage
      exit 1
      ;;
  esac
done
usage
