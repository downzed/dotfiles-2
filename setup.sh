#!/usr/bin/env bash

bold=$(tput bold)
norm=$(tput sgr0)
warn=$(tput setaf 1)

PACKAGES=(
    vim
    vim-nox
    vim-gnome
    htop
    zsh
    build-essential
    cmake
    python3-dev
    git
    curl
    wget
)

function install_ohmyzsh() {

    if [[ -d ~/.dotfiles/oh-my-zsh ]]; then
        echo "${bold}Oh My Zsh is already installed!${norm}"
        exit
    fi

    echo "${bold}==> Installing Oh My Zsh...${norm}"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.dotfiles/oh-my-zsh
    cp ~/.zshrc ~/.zshrc.orig
    ln -s ~/.dotfiles/zshrc.zsh-template ~/.zshrc
    chsh -s $(which zsh)
    echo "🍻 ${bold}Oh-my-zsh has been installed!${norm}"
}

function install_essential_packages() {
    echo "${bold}==> Installing essential packages...${norm}"
    echo "Packages: ${PACKAGES[@]}"
    sudo apt update && sudo apt upgrade
    sudo apt install -y ${PACKAGES[@]}
    echo "🍻 ${bold}Essential packages has been installed!${norm}"
}

function install_vim() {
    echo "${bold}==> Installing VIM${norm}"
    if [[ -d ~/.vim ]]; then
        cp -r ~/.vim ~/.vim-orig
    fi

    cp -r ~/.dotfiles/vim ~/.vim

    echo "${bold}==> Installing vim-plug${norm}"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
    echo "🍻 ${bold}VIM has been installed!${norm}"
}


# Lista de programas disponibles para instalar.
PROGRAMS=(
    $(typeset -f | awk '/^install_/ {gsub(/install_/, ""); print $1}')
)

function list_programs() {
    echo "${bold}==> You can install the following:${norm}"
    for program in ${PROGRAMS[@]}; do 
        echo "- $program"
    done
}

for arg in "$@"; do
    case $arg in
        all)
            for program in ${PROGRAMS[@]}; do
                install_program="install_${program}"
                $exec_install_program
            done
            ;;
        
        list)
            list_programs
            ;;
        *)
            if  [[ "${PROGRAMS[@]}" =~ "${arg}" ]]; then
                install_program="install_${arg}"
                $install_program
            else
                echo "${warn}It's not possible to install: ${bold}${program}${norm}"
                list_programs
            fi 
            ;;
    esac
done
