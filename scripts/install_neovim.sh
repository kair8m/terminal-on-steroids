#!/usr/bin/env bash

echo "Installing neovim latest version..."

function linux_install() {
    sudo apt-get install apt-utils software-properties-common -yy > /dev/null
    sudo add-apt-repository ppa:neovim-ppa/unstable -yy > /dev/null
    sudo apt-get update -yy > /dev/null
    sudo apt-get upgrade -yy > /dev/null
    sudo apt-get install neovim -yy > /dev/null
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

