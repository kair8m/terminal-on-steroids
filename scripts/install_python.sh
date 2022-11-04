#!/usr/bin/env bash

PYTHON_VERSION="3.10"

function linux_install() {
    if (($EUID != 0)); then
        if [[ -t 1 ]]; then
            sudo "$0" "$@"
        else
            exec 1>output_file
            gksu "$0 $@"
        fi
        exit
    fi
    apt-get install software-properties-common -yy
    add-apt-repository ppa:deadsnakes/ppa -yy
    apt-get update -yy
    apt-get install python${PYTHON_VERSION} -yy
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
