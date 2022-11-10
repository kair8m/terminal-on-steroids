#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function setup_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    git clone https://github.com/zsh-users/zsh-autosuggestions          "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
    git clone https://github.com/joshskidmore/zsh-fzf-history-search    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-fzf-history-search
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/themes/powerlevel10k
    DOTFILES_DIR=$(realpath "$SCRIPT_DIR/../dotfiles")
    cp -r "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    cp -r "$DOTFILES_DIR/.pythonrc" "$HOME/.pythonrc"
    cp -r "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
    cp -r "$DOTFILES_DIR/.fdignore" "$HOME/.fdignore"
    mkdir -p "$HOME/.config/lazygit"
    cp -r "$DOTFILES_DIR/lazygit/config.yml" "$HOME/.config/lazygit/"
    mkdir -p "$HOME/.config/dotfiles"
    cp -r "$DOTFILES_DIR/"*.sh "$HOME/.config/dotfiles/"
    shell_scripts="$HOME/.config/dotfiles/*.sh"
    for shell_script in $shell_scripts
    do
        echo "source $shell_script" >> "$HOME/.zshrc"
    done
}

function setup_on_linux() {
    sudo apt-get update -yy
    sudo apt-get install curl wget fzf ripgrep tmux make cmake g++ gcc bat build-essential zip unzip dpkg tmux fd-find -yy

    cd /tmp/ || exit

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
    rm -rf lazygit.tar.gz

    wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta_0.14.0_amd64.deb
    sudo dpkg -i git-delta_0.14.0_amd64.deb
    rm git-delta_0.14.0_amd64.deb -rf
    cd - || exit

    sudo apt-get install zsh -yy

    mkdir -p "${HOME}"/.local/bin
    
    ln -s "$(which batcat)" "${HOME}"/.local/bin/bat
    ln -s "$(which fdfind)" "${HOME}"/.local/bin/fd
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

"$SCRIPT_DIR"/install_python.sh
"$SCRIPT_DIR"/install_node.sh
"$SCRIPT_DIR"/install_neovim.sh

setup_zsh
