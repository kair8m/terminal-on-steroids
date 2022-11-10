#!/usr/bin/env bash

PYTHON_VERSION="3.10"

function linux_install() {
    sudo sudo apt-get install software-properties-common -yy
    add-apt-repository ppa:deadsnakes/ppa -yy
    sudo sudo apt-get update -yy
    sudo sudo apt-get install python${PYTHON_VERSION} -yy
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
