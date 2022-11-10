#!/usr/bin/env bash

function linux_install() {
    sudo apt-get install software-properties-common -yy
    add-apt-repository ppa:neovim-ppa/unstable -yy
    sudo apt-get update -yy
    sudo apt-get install neovim -yy
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

