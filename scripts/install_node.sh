#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function linux_install() {
    source $SCRIPT_DIR/check_linux_rights.sh

    validate_root_access_rights

    apt-get install software-properties-common -yy
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt-get update -yy
    apt-get install nodejs -yy
}

case "$OSTYPE" in
  linux*)   linux_install ;;
  darwin*)  echo "Mac OS" ;; 
  win*)     echo "Windows" ;;
  msys*)    echo "MSYS / MinGW / Git Bash" ;;
  cygwin*)  echo "Cygwin" ;;
  bsd*)     echo "BSD" ;;
  solaris*) echo "Solaris" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

