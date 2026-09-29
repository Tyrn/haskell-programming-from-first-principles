#!/usr/bin/env bash

set -euo pipefail

# Yet another way to run tests;
# this one without cabal test.
TEST_SUITE="haskell-programming-from-first-principles-test"

usage() {
  cat <<EOF
Usage: $0 [OPTIONS] [PATH]

  (no args)    run all tests
  PATH         run by full match path, e.g. 'Appendix A/context'

Options:
  -s, --stream      stream output as tests run (--test-show-details=streaming)
  -a N, --max N     run N QuickCheck tests per property (default 100)
  -h, --help        show this message

Examples:
  $0
  $0 'datatypes'
  $0 -s 'TraversableInstances'
  $0 -a 30 'TraversableInstances'
EOF
}

# Defaults
STREAM=0
MAX_SUCCESS=""

# Parse options up to the first non-option argument.
while [ $# -gt 0 ]; do
  case "$1" in
  -h | --help)
    usage
    exit 0
    ;;
  -s | --stream)
    STREAM=1
    shift
    ;;
  -a | --max)
    if [ $# -lt 2 ]; then
      echo "error: $1 requires an argument" >&2
      exit 2
    fi
    MAX_SUCCESS="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  -*)
    echo "error: unknown option: $1" >&2
    usage >&2
    exit 2
    ;;
  *)
    break
    ;;
  esac
done

arg="${1:-}"

# Build the hspec arguments.
hspec_args=(--format=specdoc)

if [ -n "$arg" ]; then
  hspec_args+=(--match="$arg")
fi

if [ -n "$MAX_SUCCESS" ]; then
  hspec_args+=(-a "$MAX_SUCCESS")
fi

# Run.
if [ "$STREAM" -eq 1 ]; then
  cabal run "$TEST_SUITE" --test-show-details=streaming -- "${hspec_args[@]}"
else
  cabal run "$TEST_SUITE" -- "${hspec_args[@]}"
fi
