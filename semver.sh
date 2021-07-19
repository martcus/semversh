#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------
# Semantic Version
# Copyright (c) Marco Lovazzano
# Licensed under the GNU General Public License v3.0
# http://github.com/martcus
#--------------------------------------------------------------------------------------------------

SEMVERSH_APPNAME="semversh"
SEMVERSH_VERSION="0.0.1"
SEMVERSH_BASENAME=$(basename "$0")

readonly SEMVERSH_APPNAME
readonly SEMVERSH_VERSION
readonly SEMVERSH_BASENAME

DEBUG_MODE="N"

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

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

# Internal function for debugging
function _debug() {
    if [ $DEBUG_MODE = "Y" ]; then
        echo "debug> $*"
    fi
}

# Get the options
while getopts ":h" option ; do
    case $option in
        h)  #Display the usage
            _usage
            exit;;
        \?) #Invalid option
            echo "Error: Invalid option"
            exit;;
    esac
done
