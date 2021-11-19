#!/bin/bash
set -e

# shellcheck disable=SC1091
source "$PROJECT_DIR/lib/colors.sh"

function log_info () {
  echo "${CYAN}[INFO ]${NOCOLOR} $1"
}

function log_error () {
  echo "${LIGHT_RED}[ERROR]${NOCOLOR} $1"
}

function log_warn () {
  echo "${YELLOW}[WARN ]${NOCOLOR} $1"
}

function log_debug () {
  echo "${LIGHT_GRAY}[DEBUG]${NOCOLOR} $1"
}
