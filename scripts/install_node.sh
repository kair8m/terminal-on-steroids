#!/usr/bin/env bash

echo "Installing latest nodejs version..."

function linux_install() {
    sudo apt-get install software-properties-common -yy > /dev/null
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - > /dev/null
    sudo apt-get update -yy > /dev/null
    sudo apt-get install nodejs -yy > /dev/null
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

