#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function setup_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions          "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions > /dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting > /dev/null
    git clone https://github.com/joshskidmore/zsh-fzf-history-search    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/zsh-fzf-history-search > /dev/null
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git    "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/themes/powerlevel10k > /dev/null
    DOTFILES_DIR=$(realpath "$SCRIPT_DIR/../dotfiles")
    cp -r "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    cp -r "$DOTFILES_DIR/.pythonrc" "$HOME/.pythonrc"
    cp -r "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
    cp -r "$DOTFILES_DIR/.fdignore" "$HOME/.fdignore"
    cp -r "$DOTFILES_DIR/.profile" "$HOME/.profile"
    mkdir -p "$HOME/.config/lazygit"
    cp -r "$DOTFILES_DIR/lazygit/config.yml" "$HOME/.config/lazygit/"
    mkdir -p "$HOME/.config/dotfiles"
    cp -r "$DOTFILES_DIR/"*.sh "$HOME/.config/dotfiles/"
}

function setup_neovim() {
    echo "Setting up neovim..."
    source "$HOME/.profile"
    source "$HOME/.cargo/env"
    mkdir -p "$HOME/.config"
    NVIM_DIR=$(realpath "$SCRIPT_DIR/../nvim")
    cp -r "$NVIM_DIR" "$HOME/.config"
    cargo install deno --locked
    # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'TSUpdate'
    # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'TSUpdateSync'

}

function setup_on_linux() {
    echo "performing apt-get update && apt-get upgrade..."
    sudo apt-get update -yy > /dev/null
    sudo apt-get install curl wget fzf ripgrep tree tmux make cmake g++ gcc bat build-essential zip unzip dpkg tmux fd-find -yy > /dev/null

    cd /tmp/ || exit

    echo "Installing lazygit..."


    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
    rm -rf lazygit.tar.gz

    echo "Installing git delta..."

    wget https://github.com/dandavison/delta/releases/download/0.14.0/git-delta_0.14.0_amd64.deb
    sudo dpkg -i git-delta_0.14.0_amd64.deb
    rm git-delta_0.14.0_amd64.deb -rf
    cd - || exit

    sudo apt-get install zsh -yy > /dev/null

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
"$SCRIPT_DIR"/install_rust.sh
"$SCRIPT_DIR"/install_node.sh
"$SCRIPT_DIR"/install_neovim.sh

setup_zsh
setup_neovim
