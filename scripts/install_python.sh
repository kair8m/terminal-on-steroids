#!/usr/bin/env bash

PYTHON_VERSION="3.10"

echo "Installing python$PYTHON_VERSION..."

function linux_install() {
    sudo sudo apt-get install software-properties-common -yy > /dev/null
    sudo add-apt-repository ppa:deadsnakes/ppa -yy > /dev/null
    sudo sudo apt-get update -yy > /dev/null
    sudo sudo apt-get install python${PYTHON_VERSION} python${PYTHON_VERSION}-venv -yy > /dev/null
    wget https://bootstrap.pypa.io/get-pip.py
    python$PYTHON_VERSION get-pip.py

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
