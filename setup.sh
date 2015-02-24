#!/bin/bash
# Simple Script for setting up my workspace


# Parse username and email
read -p "Enter your Git username: " USER_NAME
echo
read -p "Enter your Git email: " USER_EMAIL

# Restore Git config
cp ./gitconfig ~/.gitconfig

if [ "${OSTYPE:0:6}" == "darwin" ] ; then
    SED_IN_PLACE_CMD="sed -i .bak"
else
    SED_IN_PLACE_CMD="sed -i"
fi

${SED_IN_PLACE_CMD} "s/{USER_NAME}/${USER_NAME}/" ~/.gitconfig
${SED_IN_PLACE_CMD} "s/{USER_EMAIL}/${USER_EMAIL}/" ~/.gitconfig

# Restore Vim config
cp -r ./vim ~/.vim
cp ./vimrc ~/.vimrc

# Update bashrc with git branch prompt
cp ./git-prompt.sh ~/.git-prompt.sh
cp ./bashrc ~/.bashrc

echo "Done! Launch a new terminal and run brewInstall.sh"
