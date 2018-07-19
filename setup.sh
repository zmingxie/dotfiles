#!/bin/bash
# Simple Script for setting up my workspace


# Parse username and email
read -p "Enter your Git username: " USER_NAME
echo
read -p "Enter your Git email: " USER_EMAIL

# Restore Git config
ln -s ${PWD}/gitconfig ~/.gitconfig

if [ "${OSTYPE:0:6}" == "darwin" ] ; then
    SED_IN_PLACE_CMD="sed -i .bak"
else
    SED_IN_PLACE_CMD="sed -i"
fi

${SED_IN_PLACE_CMD} "s/{USER_NAME}/${USER_NAME}/" ~/.gitconfig
${SED_IN_PLACE_CMD} "s/{USER_EMAIL}/${USER_EMAIL}/" ~/.gitconfig

# Enable git autocorrect for half second
git config --global help.autocorrect 5

# Restore Vim config
ln -s ${PWD}/vim ~/.vim
ln -s ${PWD}/vimrc ~/.vimrc

# Update bashrc with git branch prompt
ln -s ${PWD}/git-prompt.sh ~/.git-prompt.sh
ln -s ${PWD}/bashrc ~/.bashrc

# ZSH setup
ln -s ${PWD}/zshrc ~/.zshrc
ln -s ${PWD}/tmux.conf ~/.tmux.conf

# VS Code setup
ln -s ${PWD}/settings.json "${HOME}/Library/Application Support/Code/User/settings.json"
echo "Done! Launch a new terminal and run brewInstall.sh"
