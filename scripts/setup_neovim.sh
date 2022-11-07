#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function setup_on_linux() {
    source $SCRIPT_DIR/check_linux_rights.sh
    validate_root_access_rights
    apt-get update -yy
    apt-get install curl wget fzf ripgrep tmux make cmake g++ gcc build-essential zip unzip -yy

    cd /tmp/ || exit

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
    rm -rf lazygit.tar.gz

    cd - || exit
}

case "$OSTYPE" in
  linux*)   setup_on_linux ;;
  darwin*)  echo "Mac OS" ;; 
  win*)     echo "Windows" ;;
  msys*)    echo "MSYS / MinGW / Git Bash" ;;
  cygwin*)  echo "Cygwin" ;;
  bsd*)     echo "BSD" ;;
  solaris*) echo "Solaris" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

$SCRIPT_DIR/install_python.sh
$SCRIPT_DIR/install_node.sh
$SCRIPT_DIR/install_neovim.sh
