#!/usr/bin/env bash

function linux_install() {
    sudo apt-get install software-properties-common -yy
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get update -yy
    sudo apt-get install nodejs -yy
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

