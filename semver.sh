#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------
# Semantic Version
# Copyright (c) Marco Lovazzano
# Licensed under the GNU General Public License v3.0
# http://github.com/martcus
#--------------------------------------------------------------------------------------------------

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Enable xtrace if the DEBUG environment variable is set. Useful while debugging
if [[ ${DEBUG-} =~ ^1|yes|true$ ]]; then
    set -o xtrace       # Trace the execution of the script (debug)
fi

SEMVERSH_APPNAME="semversh"
SEMVERSH_VERSION="0.0.1"
SEMVERSH_BASENAME=$(basename "$0")
SEMVERSH_REGEX="^([0-9]+)\.([0-9]+)\.([0-9]+)$"

readonly SEMVERSH_APPNAME
readonly SEMVERSH_VERSION
readonly SEMVERSH_BASENAME
readonly SEMVERSH_REGEX

# internal function - print version
function _version() {
    echo -e ""
    echo -e "$SEMVERSH_APPNAME v$SEMVERSH_VERSION"
    echo -e "Semantic Version"
    echo -e "Copyright (c) Marco Lovazzano"
    echo -e "Licensed under the GNU General Public License v3.0"
    echo -e "http://github.com/martcus"
    echo -e ""
}

# internal function - print help page
function _usage() {
    _version
    echo -e "Usage: $SEMVERSH_BASENAME [OPTIONS] major.minor.patch"
    echo -e "   -h: Print this help"
    echo -e ""
}

# Internal function for fatal error, print message in stderr and exit with 1 as exitcode
function _fatal {
  echo -e "$@" >&2
  exit 1
}

if [[ ! $1 =~ $SEMVERSH_REGEX ]]; then
    _fatal "semver doesn't match with pattern <major.minor.patch>"
fi
