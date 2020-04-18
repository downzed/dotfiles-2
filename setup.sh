#!/bin/bash

bold=$(tput bold)
norm=$(tput sgr0)

PACKAGES=(
    vim
    htop
    zsh
    build-essential
    git
    curl
    wget
)

install_ohmyzsh() {

    if [[ -d ~/.dotfiles/oh-my-zsh ]]; then
        echo "${bold}Oh My Zsh is already installed!${norm}"
        exit
    fi

    echo "${bold}==> Install Oh My Zsh...${norm}"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.dotfiles/oh-my-zsh
    cp ~/.zshrc ~/.zshrc.orig
    cp ~/.dotfiles/zshrc.zsh-template ~/.zshrc
    chsh -s $(which zsh)
    echo "${bold}==> Oh My Zsh installed 🍻"
}

install_essential_packages() {
    echo "${bold}==> Install essential packages...${norm}"
    echo "Packages: ${PACKAGES[@]}"
    sudo apt update && sudo apt upgrade
    sudo apt install -y ${PACKAGES[@]}
    echo "${bold}==> Essential packages installed 🍻"
}

install_essential_packages
install_ohmyzsh
